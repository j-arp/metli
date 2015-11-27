require 'rails_helper'

RSpec.describe Chapter, type: :model do

  describe '#published?' do

    it 'is published' do
      chapter = FactoryGirl.build(:chapter, {published_on: Time.now})
      expect(chapter).to be_published
    end

    it 'is not published' do
      chapter = FactoryGirl.build(:chapter, {published_on: nil})
      expect(chapter).to_not be_published
    end
  end


  describe '#unpublish?' do

    it 'returns true if there are no future chapters published' do
      chapter = FactoryGirl.create(:chapter, published_on: Time.now, number: 4)
      previous_chapter = FactoryGirl.create(:chapter, published_on: Time.now - 3.days, number: 3)
      expect(chapter.unpublish?).to eq true
    end

    it 'returns false if there are future published chapters' do
        chapter = FactoryGirl.create(:chapter, published_on: Time.now, number: 4)
        last_chapter = FactoryGirl.create(:chapter, story_id: chapter.story_id, published_on: (Time.now + 3.days), number: 5)
        expect(chapter.unpublish?).to eq false
    end
  end
end
