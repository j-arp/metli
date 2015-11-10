module Manage
  class StoriesController < ApplicationController
    before_action :set_story, only: [:show, :edit, :update, :destroy]
    before_action :get_users, only: [:new, :edit, :create, :update]

    # GET /stories
    # GET /stories.json
    def index
      if active_user.super_user?
        @stories = Story.all
      else
        @stories = active_user.authored_stories
      end
    end

    # GET /stories/1
    # GET /stories/1.json
    def show
    end

    # GET /stories/new
    def new
      @story = Story.new
    end

    # GET /stories/1/edit
    def edit
    end

    # POST /stories
    # POST /stories.json
    def create
      @story = Story.new(story_params)

      respond_to do |format|
        if @story.save
          assign_author
          format.html { redirect_to manage_story_path(@story), notice: 'Story was successfully created.' }
          format.json { render :show, status: :created, location: @story }
        else
          format.html { render :new }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /stories/1
    # PATCH/PUT /stories/1.json
    def update
      respond_to do |format|
        if @story.update(story_params)
          format.html { redirect_to manage_story_path(@story), notice: 'Story was successfully updated.' }
          format.json { render :show, status: :ok, location: @story }
        else
          format.html { render :edit }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /stories/1
    # DELETE /stories/1.json
    def destroy
      @story.destroy
      respond_to do |format|
        format.html { redirect_to manage_stories_url, notice: 'Story was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

      def assign_author
        if active_user.super_user? && params[:author_id]
          user = User.find(params[:author_id])
          user.subscribe_to(@story, user.full_name, {author: true})
        else
          active_user.subscribe_to(@story, 'Author', {author: true})
        end
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_story
        @story = Story.find(params[:id])
      end

      def get_users
        @active_user = active_user
        @users || @users = User.all
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def story_params
        params.require(:story).permit(:name, :active, :taxonomy)
      end
  end
end
