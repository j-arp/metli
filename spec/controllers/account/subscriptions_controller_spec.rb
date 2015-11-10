require 'rails_helper'

RSpec.describe Account::SubscriptionsController, type: :controller do

  before(:each) do
    @story = FactoryGirl.create(:story)
    @user = FactoryGirl.create(:user)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #add" do
    it "creates a subscription" do

      expect {

      post :add, {story_id: @story.id, username: 'jesse'}, {user_id: @user.id}
      }.to change(Subscription, :count).by(1)


    end

    it "redirects back to account" do
      post :add, {story_id: @story.id, username: 'jesse'}, {user_id: @user.id}
      expect(response).to redirect_to account_path
    end


  end

  describe "GET #remove" do
    it "returns http success" do
      @subscription = @user.subscribe_to(@story, 'jesse')
      expect {
        get :remove,  {subscription_id: @subscription.id, username: 'jesse'}, {user_id: @user.id}
      }.to change(Subscription, :count).by(-1)

    end
  end

end
