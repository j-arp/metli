require 'rails_helper'

RSpec.describe CallToAction, type: :model do

  describe 'percent_of_vote' do
    it 'returns the percent of total a vote got' do
    end
  end

  describe 'progress' do
    it 'the percent done' do
      chapter = double("chapter")
      call = FactoryGirl.build(:call_to_action)
      allow(call).to receive_message_chain("chapter.story.subscriptions.count") {4}
      allow(call).to receive_message_chain("chapter.votes.count") {3}
      expect(call.progress).to eq 75
    end

    it 'the roudned percent done' do
      chapter = double("chapter")
      call = FactoryGirl.build(:call_to_action)
      allow(call).to receive_message_chain("chapter.story.subscriptions.count") {3}
      allow(call).to receive_message_chain("chapter.votes.count") {2}
      expect(call.progress).to eq 67
    end

    it 'returns 0% if no votes' do
      chapter = double("chapter")
      call = FactoryGirl.build(:call_to_action)
      allow(call).to receive_message_chain("chapter.story.subscriptions.count") {2}
      allow(call).to receive_message_chain("chapter.votes.count") {0}
      expect(call.progress).to eq 0
    end
  end

end
