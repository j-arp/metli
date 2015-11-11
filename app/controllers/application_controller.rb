class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_all_stories
  before_action :active_user

  def get_all_stories
    @stories || @stories = Story.all
  end

  def active_user
    if session[:user_id]
      @active_user || @active_user = User.find(session[:user_id])
    end
  end

  def find_story
    @story || @story = Story.find(params[:story_id]) if params[:story_id]
  end

  def require_login
    redirect_to login_path unless session[:user_id]
  end

  def require_super_user_login
    redirect_to login_path unless active_user.super_user?
  end
end
