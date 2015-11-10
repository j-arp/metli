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
    puts params
     user = User.find_by(email: params[:email])
     puts user.inspect

     if user
      session[:user_id] = user.id
      session[:managed_story_id] = user.stories.first.id if user.stories.any?
      session[:current_story_id] = user.stories.first.id if user.stories.any?
      flash[:message] = 'You have been logged in'
      redirect_to account_path

    else
      flash[:message] = 'Nope!'
      redirect_to login_path
    end

  end

  def logout
    session[:user_id] = nil
    flash[:message] = "You have been logged out"
    redirect_to login_path
  end

  private

  def get_users
    @active_user = active_user
    @users || @users = User.all
  end
end
