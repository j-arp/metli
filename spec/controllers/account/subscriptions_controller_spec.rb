require 'rails_helper'

RSpec.describe Account::SubscriptionsController, type: :controller do

  before(:each) do
    @story = FactoryGirl.create(:story)
    @user = FactoryGirl.create(:user)
  end

  describe "GET #index" do

    before(:each) do
      @user.subscribe_to(@story, 'foobar')
    end

    it "requires an active session" do
      get :index, {}, {}
      expect(response).to redirect_to login_path
    end

    it "returns subscriptions" do
      get :index, {}, {user_id: @user.id }
      expect(assigns(:subscriptions)).to eq @user.subscriptions
    end

    it "returns subscriptions decorated" do
      get :index, {}, {user_id: @user.id }
      expect(assigns(:subscriptions).first).to be_decorated_with SubscriptionDecorator
    end

  end

  describe "POST #add" do
    it "creates a subscription" do

      expect {
      post :add, {story_id: @story.id, username: 'jesse'}, {user_id: @user.id, subscribed_stories: ""}
      }.to change(Subscription, :count).by(1)


    end

    it "redirects back to account" do
      post :add, {story_id: @story.id, username: 'jesse'}, {user_id: @user.id, subscribed_stories: ""}
      expect(response).to redirect_to account_subscriptions_path
    end


  end

  describe "GET #remove" do

    before(:each) do
      @subscription = @user.subscribe_to(@story, 'jesse')
    end

    it "returns http success" do
      expect {
        get :remove,  {subscription_id: @subscription.id, username: 'jesse'}, {user_id: @user.id}
      }.to change(Subscription, :count).by(-1)

    end

    it "redirects back to account" do
      post :remove, {subscription_id: @subscription.id, username: 'jesse'}, {user_id: @user.id, subscribed_stories: "#{@subscription.story_id},42"}
      expect(response).to redirect_to account_subscriptions_path
    end

    it "updates session values" do
      post :remove, {subscription_id: @subscription.id, username: 'jesse'}, {user_id: @user.id, subscribed_stories: "#{@subscription.story_id},42"}
      expect(session[:subscribed_stories]).to eq "42"
    end

  end

end
