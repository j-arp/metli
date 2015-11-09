class AccountController < ApplicationController
  def index
  end

  def login
  end

  def process_login
      puts params
     user = User.find_by(email: params[:email])
     puts user.inspect

     if user
      session[:user_id] = user.id
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
end
