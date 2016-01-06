require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    FactoryGirl.build(:user)
  }


  describe "Activity Level" do

    before(:each) do
      @user = FactoryGirl.build(:user)
      Vote.stub(:count).and_return(10)
    end

    it 'returns 0 (a numeric value based on votes, views, etc) for a new user' do
      expect(@user.activity_level).to eq 0
    end

    it 'returns  40 if case 4 of 10 possible votes' do
      @user.stub(:votes).and_return(%w(one two three votes))
      expect(@user.activity_level).to eq 40
    end

    it 'returns  50 if case 4 of 10 possible votes and authored a story' do
      @user.stub(:votes).and_return(%w(one two three votes))
      @user.stub(:authored_stories).and_return(%w(one))
      expect(@user.activity_level).to eq 50
    end

  end


  describe 'scopes' do
    before(:each) do
      3.times do
        FactoryGirl.create(:user)
      end

      @story = FactoryGirl.create(:story)
      @user = User.last
    end

    it 'returns users by last login' do
      u1 = User.first
      u1.update(last_login_at: Time.now - 3.days)
      u2 = User.first
      u2.update(last_login_at: Time.now - 1.days)

      expect(User.by_activity.first).to eq u2

    end

    it 'returns no authors cuz non exist' do
      @user.subscribe_to(@story, 'asdf')
      expect(User.authors).to be_empty
    end

    it 'returns one author' do
      @user.subscribe_to(@story, 'asdf', author: true)
      expect(User.authors).to_not be_empty
    end

    it 'does not return deleted users' do
      expect(User.count).to eq 4
      User.first.delete
      expect(User.count).to eq 3
    end
  end

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

    it 'subscribes a user to a story and defaults to sending emails' do
      @user.subscribe_to(@story, 'jesse')
      expect(@user.stories.count).to eq 1
      expect(Subscription.last.send_email).to eq true
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
