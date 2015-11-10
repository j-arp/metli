require 'rails_helper'

RSpec.describe AccountController, type: :controller do

  before(:all) do
    @user = FactoryGirl.create(:user)
    @story = FactoryGirl.create(:story)
    @other_story = FactoryGirl.create(:story)
  end

  after(:all) do
    @story.destroy
  end

  let(:valid_session) { {user_id: @user.id} }

  describe "GET #index" do
    it "assigns a list of stories to both subscribed and available" do
      @user.subscribe_to(@story, 'jesse')
      get :index, {}, valid_session
      expect(response).to have_http_status(:success)
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
    it "returns http success" do
      user = FactoryGirl.create(:user, {email: 'jesse@arp.com', author: true, story_id: @story.id})
      post :process_login, {email: 'jesse@arp.com'}
      expect(session[:user_id]).to_not be_nil
      #expect(session[:current_story_id]).to_not be_nil
      #expect(session[:managed_story_id]).to_not be_nil
    end

    it "redirect to account" do
      user = FactoryGirl.create(:user, {email: 'jesse@arp.com', author: true, story_id: @story.id})
      post :process_login, {email: 'jesse@arp.com'}
      expect(response).to redirect_to account_path
    end

    it 'redirects to story public view if not an author' do
      user = FactoryGirl.create(:user, {email: 'jesse@arp.com', author: false, story_id: @story.id})
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
