require 'rails_helper'

RSpec.describe Subscription, type: :model do

  subject {
    FactoryGirl.build(:subscription)
  }


  it 'returns the next undread chapter' do
    expect(subject.next_chapter).to eq nil
  end


    it 'returns the last chapter voted on' do
      expect(subject.last_voted_chapter_number).to eq nil
    end


  context 'roles' do


    it 'responds to privileged?' do
      expect(subject).to_not be_privileged
      subject.privileged = true
      expect(subject).to be_privileged
    end

    it 'responds to active?' do
      expect(subject).to be_active
      subject.active = false
      expect(subject).to_not be_active
    end

    it 'responds to author?' do
      expect(subject).to_not be_author
      subject.author = true
      expect(subject).to be_author
    end

  end


  context 'scopes' do
    it 'returns only active users' do
      user = FactoryGirl.create(:user)
      story1 = FactoryGirl.create(:story)
      story2 = FactoryGirl.create(:story)

      user.subscribe_to(story1, 'jesse')

      expect(user.stories.subscribed.count).to be 1
      expect(user.stories.subscribed.first).to eq story1
      expect(user.stories.available.count).to be 1
      expect(user.stories.available.first).to eq story2
    end
=begin
    it 'returns only active users' do
      FactoryGirl.create(:user)
      FactoryGirl.create(:user)
      expect(User.active.count).to eq 1
    end

    it 'returns only authors' do
      FactoryGirl.create(:user)
      FactoryGirl.create(:user, author: true)
      expect(User.authors.count).to eq 1
    end

    it 'returns only privileged users' do
      FactoryGirl.create(:user)
      FactoryGirl.create(:user, privileged: true)
      expect(User.privileged.count).to eq 1
    end
=end

  end

end
