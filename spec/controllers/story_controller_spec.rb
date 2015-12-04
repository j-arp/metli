require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe StoryController, type: :controller do
  include_context "user_with_supscriptions"

  describe "GET #index" do

    it 'redirects to choose story if no current story is in session' do
        valid_session[:current_story_id] = nil
        get :index, {}, valid_session
        expect(response).to redirect_to choose_story_path
    end
  end

  describe "GET #choose" do
    it "returns @subscriptions" do
      get :choose, {}, valid_session
      expect(assigns(:subscriptions)).to_not be_nil
    end

    it "returns a Decorated @subscriptions" do
      get :choose, {}, valid_session
      expect(assigns(:subscriptions).first).to be_decorated_with SubscriptionDecorator
    end

    it "sets new story as current" do
      post :choose, {id: @other_story.id}, valid_session
      expect(session[:current_story_id]).to eq @story.id
    end

    it "redirects back to story" do
      post :set_current_story_id, {id: @other_story.id}, valid_session
      expect(response).to redirect_to story_path
    end
  end


  describe "GET #chapter" do
    it "returns http success" do
      puts @chapter.inspect
      get :chapter, {number: 1}, valid_session
      expect(assigns(:chapter)).to eq @chapter
    end


    it 'sets control variable to allow voting' do
      get :chapter, {number: 1}, valid_session
      expect(assigns(:allow_voting)).to eq true
    end

    it 'sets control variable to not allow voting' do
      vote = FactoryGirl.create(:vote, {user_id: @user.id, votable_type: 'Action', votable_id: @chapter.actions.first.id})
      get :chapter, {number: 1}, valid_session
      expect(assigns(:allow_voting)).to eq false
    end

    it 'does not allow voting if user has not voted but voting has ended' do
      @chapter.vote_ends_on = Time.now - 1.day
      @chapter.save
      get :chapter, {number: 1}, valid_session
      expect(assigns(:allow_voting)).to eq false
    end
  end
end
