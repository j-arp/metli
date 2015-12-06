require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe Manage::SubscribersController, type: :controller do
  include_context "user_with_supscriptions"

  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.subscribe_to(@story, 'new_sub')
    @subscription = @user.subscriptions.last
  end

  describe "POST #promote" do

    it "sets subscription for user and story" do
      post :promote, {story_id: @story.id, user_id: @user.id}, valid_session
      expect(assigns(:subscription)).to_not be_nil
      expect(assigns(:subscription).user).to eq @user
      expect(assigns(:subscription).story).to eq @story
    end

    it "promotes user's subscription to promoted" do
      post :promote, {story_id: @story.id, user_id: @user.id}, valid_session
      expect(assigns(:subscription)).to be_privileged
    end

    # it "promotes user's and returns json" do
    #   xhr :promote, {story_id: @story.id, user_id: @user.id}, valid_session
    #   expect(assigns(:subscription)).to be_privileged
    # end
  end

  describe "POST #relegate" do

    it "relegates pathetic user to not being privledged" do
      post :relegate, {story_id: @story.id, user_id: @user.id}, valid_session
      expect(assigns(:subscription)).to_not be_privileged
    end

  end

end
