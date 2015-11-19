require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe AccountController, type: :controller do
  include_context "user_with_supscriptions"

  describe "GET #index" do
    it "assigns a list of stories to both subscribed and available" do
      @user.subscribe_to(@story, 'jesse')
      get :index, {}, valid_session
      expect(assigns(:available_stories)).to_not be_nil
      expect(assigns(:subscriptions)).to_not be_nil
    end



    it 'redirects to login if no active session' do
      get :index
      expect(response).to redirect_to login_path
    end

  end

  describe "GET #login" do
    it "returns http success" do
      get :login
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #login" do
    context 'as User' do
      it "registers session variables" do
        post :process_login, {email: @user.email}
        expect(session[:user_id]).to eq @user.id
        expect(session[:current_story_id]).to eq @user.stories.first.id
        expect(session[:managed_story_id]).to be_nil
        expect(session[:subscribed_stories]).to eq @user.stories.map(&:id)
      end
    end

    context 'as Author' do
      it "registers session variables" do
        post :process_login, {email: @author.email}
        expect(session[:user_id]).to eq @author.id
        expect(session[:managed_story_id]).to_not be_nil
      end
    end

    it "redirect to account" do
      user = FactoryGirl.create(:user, {email: 'jesse@arp.com', author: true, story_id: @story.id})
      post :process_login, {email: 'jesse@arp.com'}
      expect(response).to redirect_to account_path
    end

    it 'redirects to story public view if not an author' do
      user = FactoryGirl.create(:user, {email: 'jesse@arp.com'})
      user.subscribe_to(@story, 'poop-boy')
      post :process_login, {email: 'jesse@arp.com'}
      #expect(response).to redirect_to story_path(@story)
    end
  end

  describe "GET #logout" do
    it "returns http success" do
      get :logout
      expect(session[:user_id]).to be_nil
      expect(session[:current_story_id]).to be_nil
      expect(session[:managed_story_id]).to be_nil
      expect(response).to redirect_to login_path
    end
  end

end
