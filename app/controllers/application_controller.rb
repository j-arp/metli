class ApplicationController < ActionController::Base
  layout 'wat_wit_canvas'
  protect_from_forgery with: :exception
  before_action :get_all_stories

  rescue_from ActiveRecord::RecordNotFound, with: :show_404
  rescue_from ActionController::RoutingError, with: :show_404

  before_action :active_user

  def get_all_stories
    @stories || @stories = Story.all
  end

  def active_user
    if session[:user_id]
      @active_user || @active_user = User.find(session[:user_id])
    end
  end

  def set_active_story
    puts "setting active sotry method from app ctr for #{session[:active_story_id]}"
    session[:active_story_id] = @story.id if @story
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

  def show_404
    render text: File.read(Rails.root.join('public/404.html')), status: 404
  end

end
