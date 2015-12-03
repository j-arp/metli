module Manage
  class ChaptersController < ApplicationController
    before_action :set_chapter, only: [:show, :edit, :update, :destroy]
    before_action :set_story
    before_action :set_publish_date, only: [:create, :update]

    # GET /chapters
    # GET /chapters.json
    def index
      @chapters = @story.chapters
    end

    # GET /chapters/1
    # GET /chapters/1.json
    def show
    end

    # GET /chapters/new
    def new
      @vote_end_options = ['1 day', '2 days', '3 days', '1 week', '2 weeks']
      @chapter = Chapter.new
      @chapter.published_on = Time.now
      @cal_to_action = CallToAction.new
    end

    # GET /chapters/1/edit
    def edit
      @vote_end_options = ['1 day', '2 days', '3 days', '1 week', '2 weeks']
      @call_to_action = @chapter.call_to_action
    end

    # POST /chapters
    # POST /chapters.json
    def create
      puts params.inspect
      @chapter = Chapter.new(chapter_params)
      @chapter.story   = @story
      @chapter.author = active_user
      @chapter.vote_ends_on = vote_cutoff_date if @chapter.published?

      respond_to do |format|
        if @chapter.save
          # puts "new chapter is #{@chapter.inspect} and its valid? #{@chapter.valid?}"
          # puts "story is #{@story.inspect}"
          # puts "last chapter is #{Chapter.last.inspect}"

          @call_to_action = CallToAction.find_or_create_by(chapter_id: @chapter.id)
          add_new_actions
          puts "is chapter publsihed? #{@chapter.published?}"
          notify if @chapter.published?

          format.html { redirect_to manage_story_chapter_path(@chapter.story, @chapter), notice: 'Chapter was successfully created.' }
          format.json { render :show, status: :created, location: @chapter }
        else
          format.html { render :new }
          format.json { render json: @chapter.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /chapters/1
    # PATCH/PUT /chapters/1.json
    def update
      respond_to do |format|
        if params[:chapter][:published_on].blank? && @chapter.unpublish?
          params[:chapter][:published_on] = nil
          flash[:message] = "Your chapter has been unpublished. It may confuse your readers."
        elsif params[:chapter][:published_on].blank? && !@chapter.unpublish?
            flash[:message] = "Your chapter cannot be unpublished!"
            params[:chapter][:published_on] = @chapter.published_on
        elsif !params[:chapter][:published_on].blank?
            #do nothing
        else
          params[:chapter][:published_on] = @chapter.published_on
        end

        @chapter.vote_ends_on = vote_cutoff_date if @chapter.published?

        if @chapter.update(chapter_params)
          @call_to_action = CallToAction.find_or_create_by(chapter_id: @chapter.id)


          notify if @chapter.published? && !@published_status
          add_new_actions
          update_previous_actions

          format.html { redirect_to manage_story_chapter_path(@story, @chapter), notice: 'Chapter was successfully updated.' }
          format.json { render :show, status: :ok, location: @chapter }
        else
          format.html { render :edit }
          format.json { render json: @chapter.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /chapters/1
    # DELETE /chapters/1.json
    def destroy
      if @chapter.unpublish?
        @chapter.destroy
        flash[:message] = 'Chapter has been deleted!'
      else
        puts "chapter can't be dleted!!!"
        flash[:message] = 'Chapter cannot be deleted! Only the last chapter can be deleted.'
      end
      respond_to do |format|
        format.html { redirect_to manage_story_chapters_path(@story) }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_chapter
        @chapter = Chapter.find(params[:id])
        @vote_end_options = ['1 day', '2 days', '3 days', '1 week', '2 weeks']
        @published_status = @chapter.published_on.blank? ? false : true
      end

      def set_story
        @story = Story.find_by_permalink(params[:story_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def chapter_params
        params.require(:chapter).permit(:number, :title, :content, :published_on, :teaser,  :author_id, :story_id, :voting_ends_after)
      end

      def set_publish_date
        if params[:publish] && params[:chapter][:published_on].blank?
          params[:chapter][:published_on] = Time.now
        elsif params[:publish].blank?
          params[:chapter][:published_on] = nil
        end
      end

      def notify
        @story.users.each do | user |
          NotifierMailer.new_chapter(@chapter, user).deliver_now
        end
      end

      def add_new_actions
        if params[:new_calls_to_action].present?
          params[:new_calls_to_action].each do | action |
            @call_to_action.actions << Action.new(content: action) if action.strip.present?
          end
        end
      end

      def update_previous_actions
        if params[:calls_to_action_ids].present?
          params[:calls_to_action_ids].each_with_index do | id, i |
            Action.find(id).update(content: params[:calls_to_action][i]) if params[:calls_to_action][i].present?
            Action.find(id).destroy if params[:calls_to_action][i].blank?
          end
        end
      end

  def vote_cutoff_date
    case params[:chapter][:voting_ends_after]
      when '1 day'
        cuttoff = DateTime.now + 1.day
      when '2 days'
        cuttoff = DateTime.now + 2.days
      when '3 days'
        cuttoff = DateTime.now + 3.days
      when '1 week'
        cuttoff = DateTime.now + 1.week
      when '2 weeks'
        cuttoff = DateTime.now + 2.weeks
      else
        cuttoff = DateTime.now + 1.week
      end
      return cuttoff.in_time_zone.midnight
    end

  end
end
