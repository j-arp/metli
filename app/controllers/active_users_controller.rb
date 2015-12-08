class ActiveUsersController < ApplicationController
  before_action :require_login
  before_action :set_active_user
  before_action :set_active_story
  before_action :active_story



  def set_active_user
    @active_user = active_user
  end

  def active_story
    puts "active sotry method from app ctr for #{session[:active_story_id]}"
    if session[:active_story_id]
      @active_story || @active_story = Story.find(session[:active_story_id])
    end
  end

  def set_active_story
    puts "setting active story from active users ctr"
    session[:active_story_id] = @story.id if @story
    session[:active_story_id] = @chapter.story.id if @chapter
  end

end
