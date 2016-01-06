class HomeController < ApplicationController
  def index
    if session[:user_id]
      redirect_to choose_story_path
    else
      render :about
    end
  end

  def about
  end
end
