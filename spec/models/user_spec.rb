require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    FactoryGirl.build(:user)
  }


  context 'access rights' do

    it 'responds to super user' do
      user = FactoryGirl.create(:user)
      expect(user).to_not be_super_user
      user.super_user = true
      expect(user).to be_super_user
    end
  end

  context 'story subscriptions' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @story = FactoryGirl.create(:story)
    end

    it 'reutrns stories user is authoring' do
      @my_story = FactoryGirl.create(:story)
      @user.subscribe_to(@story, 'jesse')
      @user.subscribe_to(@my_story, 'jesse', {author: true})
      expect(@user.authored_stories.count).to eq 1
      expect(@user.authored_stories.first).to eq @my_story
    end

    it 'returns available stories' do
      expect(@user.available_stories).to eq [@story]
    end

    it 'subscribes a user to a story' do
      @user.subscribe_to(@story, 'jesse')
      expect(@user.stories.count).to eq 1
      expect(Subscription.last).to_not be_author
      expect(Subscription.last).to_not be_privileged
      expect(Subscription.last).to be_active
    end


    it 'subscribes a user to a story as an author' do
      @user.subscribe_to(@story, 'jesse', {author: true})
      expect(@user.stories.count).to eq 1
      expect(Subscription.last).to be_author
      expect(Subscription.last).to_not be_privileged
      expect(Subscription.last).to be_active
    end

    it 'subscribes a user to a story as a privileged user' do
      @user.subscribe_to(@story, 'jesse', {privileged: true})
      expect(@user.stories.count).to eq 1
      expect(Subscription.last).to_not be_author
      expect(Subscription.last).to be_privileged
      expect(Subscription.last).to be_active
    end



  end
end
