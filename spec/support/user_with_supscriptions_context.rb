RSpec.shared_context "user_with_supscriptions" do
  before(:all) do
    @user = FactoryGirl.create(:user)
    @author = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user)

    @story = FactoryGirl.create(:story)
      @chapter = FactoryGirl.create(:chapter, {story_id: @story.id, number: 1})
      @other_chapter = FactoryGirl.create(:chapter, {story_id: @story.id, number: 2})
      @call_to_action = CallToAction.create(chapter_id: @chapter.id)
      @call_to_action.actions << FactoryGirl.create(:action, {content: "action one"})
      @call_to_action.actions << FactoryGirl.create(:action, {content: "action two"})


    @other_story = FactoryGirl.create(:story)
      FactoryGirl.create(:chapter, {story_id: @other_story.id, number: 1})
    @orphan_story = FactoryGirl.create(:story)
    @user.subscribe_to(@story, 'jarp')
    @author.subscribe_to(@story, 'arthor', {author: true})
    @user.subscribe_to(@other_story, 'jarp')
  end

  after(:all) do
    @user.destroy
    Story.destroy_all
    Chapter.destroy_all
    User.destroy_all
  end

  let(:valid_session){
    {
      user_id: @user.id,
      managed_story_id: nil,
      current_story_id: @story.id,
      subscribed_stories: [@story.id, @other_story.id]
    }
  }

  let(:valid_author_session){
    {
      user_id: @author.id,
      managed_story_id: nil,
      current_story_id: @story.id,
      subscribed_stories: [@story.id]
    }
  }
end
