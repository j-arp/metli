class AccountController < ApplicationController
  before_action :require_login, except: [:login, :process_login, :callback]

  def index
    @user = active_user
    @available_stories = active_user.available_stories
    @subscriptions = active_user.subscriptions
    @authored_stories = active_user.authored_stories
    @most_recent_story = @authored_stories.sort_by {|s| s.updated_at}.reverse.first
    @other_authored_stories = active_user.authored_stories.select{ |st| st.id != @most_recent_story.id }
    puts @other_authored_stories.count
    @story = Story.new
    get_users
  end

  def login
  end

  def info_from_the_google
    {
      email: request.env["omniauth.auth"][:info][:email],
      first_name: request.env["omniauth.auth"][:info][:first_name],
      last_name: request.env["omniauth.auth"][:info][:last_name],
      image: request.env["omniauth.auth"][:info][:image]
    }

  end

  def callback
    puts ">>>>>>> callback!!! with #{request.env["omniauth.auth"]["info"].inspect}"
    info = info_from_the_google
    @user = User.where(email: info[:email]).first_or_initialize
    @user.first_name = info[:first_name]
    @user.last_name = info[:last_name]
    @user.image = info[:image]
    @user.save
    puts @user.inspect

    if @user
      set_session(@user)
      flash[:message] = 'You have been logged in'
      redirect_to account_path
    else
      redirect_to login_path
    end
  end

  def set_session(user)
    session[:user_id] = user.id
    session[:managed_story_id] = user.authored_stories.first.id if user.authored_stories.any?
    session[:current_story_id] = user.stories.first.id if user.stories.any?
    session[:subscribed_stories] = user.stories

    user.stories.any? ? session[:subscribed_stories] = user.stories.map(&:id) : []
  end

  def process_login
     user = User.find_by(email: params[:email])

     if user
      set_session(user)
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


=begin
 Parameters: {"state"=>"3c7126df8922a60e2ac63a393534bbb2913072477b474604", "code"=>"4/-a44PeHCvBptY93Crhj3IF0Ux597RqjppxIBdBl4Xsc", "provider"=>"google"}
callback!!! with #<OmniAuth::AuthHash credentials=#<OmniAuth::AuthHash expires=true expires_at=1447955650 token="ya29.MQKFdP2wlTBAbC_9aHu3ohoRfzsLKGiFt1u4MrYUPeOQoGk65HWdPgd_cYPiEUOuE-ex"> extra=#<OmniAuth::AuthHash id_info=#<OmniAuth::AuthHash at_hash="JvUcyScM7LhpwhUzOlzHyQ" aud="1089795968509-a06nc457qji3jfmfdp8ckv06q2cm6o3d.apps.googleusercontent.com" azp="1089795968509-a06nc457qji3jfmfdp8ckv06q2cm6o3d.apps.googleusercontent.com" email="jearpster@gmail.com" email_verified=true exp=1447955651 iat=1447952051 iss="accounts.google.com" sub="101888259221695727043"> id_token="eyJhbGciOiJSUzI1NiIsImtpZCI6IjQyYjdlYjA0Mzg5ZTBjNDgyN2RmYjQwNDU5NWU1ODJkNDA0Y2IwNmYifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXRfaGFzaCI6Ikp2VWN5U2NNN0xocHdoVXpPbHpIeVEiLCJhdWQiOiIxMDg5Nzk1OTY4NTA5LWEwNm5jNDU3cWppM2pmbWZkcDhja3YwNnEyY202bzNkLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTAxODg4MjU5MjIxNjk1NzI3MDQzIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF6cCI6IjEwODk3OTU5Njg1MDktYTA2bmM0NTdxamkzamZtZmRwOGNrdjA2cTJjbTZvM2QuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJlbWFpbCI6ImplYXJwc3RlckBnbWFpbC5jb20iLCJpYXQiOjE0NDc5NTIwNTEsImV4cCI6MTQ0Nzk1NTY1MX0.aIbTkaeLZug8D47lA4vlZxwDYh0kETC_TUd2_C4yz5e8S1uiFR7r5Z_bYfvbv1lJMBCelT7uTR76pAYFzir_DlFdm5sUvXliLBFod-CAYkddxrOXWzyAmn5AtCLVFJM9DtTdwF0KUUWlf3y3-Ajm4rDsZUwoDPbFcnOVggaEcuoLcXv_TogBNOOXQBVCvC0N4YuMCQ83rJhRehvgwjerVsnX8dF1NvfumzCdiQkuCO9M3uybyMvuFfZQmQdkfHjtjX317dG1kpZdCsQ6_3i2rs2gRP5wvz6lAtQub-TMCMDGC84WVHTmPDQKzx37DlhcgxqenlQJxG3OSaecXvxqwQ" raw_info=#<OmniAuth::AuthHash email="jearpster@gmail.com" email_verified="true" family_name="Arp" gender="male" given_name="Jonathan" kind="plus#personOpenIdConnect" locale="en" name="Jonathan Arp" picture="https://lh5.googleusercontent.com/-DXn7C9uUHb8/AAAAAAAAAAI/AAAAAAAAMsU/65kIpgy4NcU/photo.jpg?sz=50" profile="https://plus.google.com/101888259221695727043" sub="101888259221695727043">>
info=#<OmniAuth::AuthHash::InfoHash
email="jearpster@gmail.com"
first_name="Jonathan"
image="https://lh5.googleusercontent.com/-DXn7C9uUHb8/AAAAAAAAAAI/AAAAAAAAMsU/65kIpgy4NcU/photo.jpg"
last_name="Arp"
name="Jonathan Arp"
urls=#<OmniAuth::AuthHash Google="https://plus.google.com/101888259221695727043">> provider="google" uid="101888259221695727043">
=end
