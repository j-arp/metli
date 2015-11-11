module Manage
  class ChaptersController < ApplicationController
    before_action :set_chapter, only: [:show, :edit, :update, :destroy]
    before_action :set_story

    # GET /chapters
    # GET /chapters.json
    def index
      @chapters = Chapter.all
    end

    # GET /chapters/1
    # GET /chapters/1.json
    def show
    end

    # GET /chapters/new
    def new
      @chapter = Chapter.new
    end

    # GET /chapters/1/edit
    def edit
    end

    # POST /chapters
    # POST /chapters.json
    def create
      @chapter = Chapter.new(chapter_params)
      @chapter.story = @story
      @chapter.author = active_user

      respond_to do |format|
        if @chapter.save
          format.html { redirect_to manage_story_chapters_path(@story, @chapter), notice: 'Chapter was successfully created.' }
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
          format.html { redirect_to manage_story_chapters_path(@story, @chapter), notice: 'Chapter was successfully updated.' }
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
        @story = Story.find(params[:story_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def chapter_params
        params.require(:chapter).permit(:number, :title, :content, :published_on, :author_id, :story_id)
      end
  end
end
