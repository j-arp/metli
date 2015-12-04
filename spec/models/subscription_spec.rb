require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe Subscription, type: :model do

  subject {
    FactoryGirl.build(:subscription)
  }


  it 'returns the last chapter voted on' do
    expect(subject.last_voted_chapter_number).to eq nil
  end

  describe 'helper methods' do
    include_context "user_with_supscriptions"

      it "returns true if user has not voted and voting has not ended" do
          expect(@user.subscriptions.first.allow_voting_for? (@chapter)).to eq true
      end

      it "returns false if user has voted bu voting has not ended" do
          Vote.create!(user: @user, votable_type: "Action", votable_id: @chapter.actions.first.id)
          @chapter.reload
          expect(@user.subscriptions.first.allow_voting_for? (@chapter)).to eq false
      end

      it "returns true if user has not voted and voting has not ended" do
          @chapter.vote_ends_on = DateTime.now - 1.day
          expect(@user.subscriptions.first.allow_voting_for? (@chapter)).to eq false
          @chapter.vote_ends_on = DateTime.now + 1.day
      end
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

end
