require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe SubscriptionDecorator do
  include_context "user_with_supscriptions"

  before(:each) do
    @subscription = SubscriptionDecorator.new(@user.subscriptions.first)
    @last_chapter = @subscription.chapters[1]
    @next_chapter = @subscription.chapters[0]

  end


  it 'returns stories chapters if called directly' do
      expect(@subscription.chapters).to eq @subscription.story.chapters
      expect(@subscription.chapters.count).to eq 2
  end

  context 'no read chapters' do

    it "returns next chapter based on what has been read" do
      expect(@subscription.next_chapter).to eq @subscription.chapters.last
    end
  end

  context 'first chapter  read' do
    it "returns next chapter based on what has been read" do
      @subscription.update(last_read_chapter_number: @subscription.chapters.last.number)
      expect(@subscription.next_chapter).to eq @subscription.chapters.first
    end
  end


  context 'all chapters read' do
    it "returns next chapter based on what has been read" do
      expect(@subscription.next_chapter).to_not be_nil
    end
  end



end
