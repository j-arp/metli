require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe StoryController, type: :controller do
  include_context "user_with_supscriptions"

  describe "GET #index" do

    it "returns http success" do
      get :index, {}, valid_session
      expect(assigns(:current_story)).to eq @story
    end
  end

  describe "GET #choose" do

    it "returns http success" do
      get :choose, {}, valid_session
      expect(assigns(:subscribed_stories)).to_not be_nil
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
      get :chapter, {number: 1}, valid_session
      expect(assigns(:chapter)).to eq @chapter
    end
  end

end