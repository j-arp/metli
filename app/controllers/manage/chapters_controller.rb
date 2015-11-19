module Manage
  class ChaptersController < ApplicationController
    before_action :set_chapter, only: [:show, :edit, :update, :destroy]
    before_action :set_story

    # GET /chapters
    # GET /chapters.json
    def index
      @chapters = @story.chapters
    end

    # GET /chapters/1
    # GET /chapters/1.json
    def show
      puts @chapter
    end

    # GET /chapters/new
    def new
      @chapter = Chapter.new
      @cal_to_action = CallToAction.new
    end

    # GET /chapters/1/edit
    def edit
      @call_to_action = @chapter.call_to_action
    end

    # POST /chapters
    # POST /chapters.json
    def create
      @chapter = Chapter.new(chapter_params)
      @chapter.story = @story
      @chapter.author = active_user

      respond_to do |format|
        if @chapter.save
          puts "new chapter is #{@chapter.inspect} and its valid? #{@chapter.valid?}"
          puts "story is #{@story.inspect}"
          puts "last chapter is #{Chapter.last.inspect}"

          @call_to_action = CallToAction.find_or_create_by(chapter_id: @chapter.id)
          add_new_actions

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
        if @chapter.update(chapter_params)

          @call_to_action = CallToAction.find_or_create_by(chapter_id: @chapter.id)

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
      @chapter.destroy
      respond_to do |format|
        format.html { redirect_to manage_story_chapters_path(@story), notice: 'Chapter was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_chapter
        @chapter = Chapter.find(params[:id])
      end

      def set_story
        @story = Story.find_by_permalink(params[:story_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def chapter_params
        params.require(:chapter).permit(:number, :title, :content, :published_on, :teaser,  :author_id, :story_id)
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
  end
end
