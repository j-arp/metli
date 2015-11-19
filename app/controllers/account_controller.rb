class AccountController < ApplicationController
  before_action :require_login, except: [:login, :process_login]
  def index
    @available_stories = active_user.available_stories
    @subscriptions = active_user.subscriptions
    @authored_stories = active_user.authored_stories
    @story = Story.new
    get_users

  end

  def login
  end

  def process_login

     user = User.find_by(email: params[:email])

     if user
      session[:user_id] = user.id
      session[:managed_story_id] = user.authored_stories.first.id if user.authored_stories.any?
      session[:current_story_id] = user.stories.first.id if user.stories.any?
      session[:subscribed_stories] = user.stories

      user.stories.any? ? session[:subscribed_stories] = user.stories.map(&:id) : []

      flash[:message] = 'You have been logged in'
      redirect_to account_path

    else
      flash[:message] = 'Nope!'
      redirect_to login_path
    end

  end

  def logout
    session[:user_id] = nil
    session[:managed_story_id] = nil
    session[:current_story_id] = nil
    session[:subscribed_stories] = nil
    flash[:message] = "You have been logged out"
    redirect_to login_path
  end

  private

  def get_users
    @active_user = active_user
    @users || @users = User.all
  end
end
