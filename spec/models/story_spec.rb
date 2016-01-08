require 'rails_helper'

RSpec.describe Story, type: :model do

  context 'scopes' do

    before(:each) do
      Story.destroy_all
      @user = FactoryGirl.create(:user)
      @story1 = FactoryGirl.create(:story, name: 'story 1 title')
        FactoryGirl.create(:chapter, story_id: @story1.id)
      @story2 = FactoryGirl.create(:story, name: 'story 2 title')
        FactoryGirl.create(:chapter, story_id: @story2.id)
    end

    after(:each) do
      Story.destroy_all
      Chapter.destroy_all
    end

    describe "#recently_completed_and_active" do
      it "returns all active but not completed stories" do
        @story1.update_attributes(completed: true, updated_at: Time.now )
        @story2.update_attributes(completed: false )
        expect(Story.recently_completed_and_active.count).to eq 2
      end
    end


    it "returns all active but not completed stories" do
      @story1.update_attributes(completed: true)
      @story2.update_attributes(completed: false)
      expect(Story.active_now).to eq [@story2]
    end

    it "returns stories compeleted in the last week" do
      @story1.update_attributes(completed: true)
      @story2.update_attributes(completed: true, updated_at: Time.now - 9.days)
      expect(Story.recently_completed).to eq [@story1]
    end

    it 'returns all active stories with chapters and not completed' do
      @story1.update_attributes(completed: true)
      expect(Story.all_completed.count).to eq 1
    end

    it 'returns all available stories for a user' do
      @user.subscribe_to(@story1, 'jesse')
      expect(Story.available_for(@user)).to eq [@story2]
    end

    it 'but doesnt return stories that are completed' do
      @user.subscribe_to(@story1, 'jesse')
      @story2.update_attributes(completed: true)
      expect(Story.available_for(@user)).to eq []
    end
  end

  describe 'status' do

    before(:each) do
      @story = FactoryGirl.build(:story)
      @chatper = FactoryGirl.create(:chapter, {story: @story, published_on: Time.now - 1.day})
    end

    it "returns 'active'  if story is active and not yet completed" do
      @story.active = true
      expect(@story.status).to eq 'Active'
    end

    it "returns 'competed'  if story is completed" do
      @story.completed=true
      expect(@story.status).to eq 'Completed'
    end

    it "returns 'started'  if story is active but no chpaters" do
      allow(@story).to receive(:chapters).and_return([])
      expect(@story.status).to eq 'Started'
    end

    it "returns 'inactive'  if story is inactive" do
      @story.active=false
      @chatper.update(published_on: nil)
      expect(@story.status).to eq 'Inactive'
    end

   end
end
