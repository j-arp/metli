RSpec.shared_context "user_with_supscriptions" do
  before(:all) do
    Subscription.destroy_all
    Action.destroy_all
    CallToAction.destroy_all
    Chapter.destroy_all
    Story.destroy_all
    User.destroy_all

    @user = FactoryGirl.create(:user)
    @super_user = FactoryGirl.create(:user, {super_user: true})
    @author = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user)

    @story = FactoryGirl.create(:story, {user: @user})
      @chapter = FactoryGirl.create(:chapter, {story_id: @story.id, number: 1, title:'I am the first chapter'})
      @other_chapter = FactoryGirl.create(:chapter, {story_id: @story.id, number: 2, title: 'I am the second chapter'})
      @call_to_action = CallToAction.create(chapter_id: @chapter.id)
      @call_to_action.actions << FactoryGirl.create(:action, {content: "action one"})
      @call_to_action.actions << FactoryGirl.create(:action, {content: "action two"})

      @call_to_action2 = CallToAction.create(chapter_id: @chapter.id)
      @call_to_action2.actions << FactoryGirl.create(:action, {content: "action three"})
      @call_to_action2.actions << FactoryGirl.create(:action, {content: "action four"})

    @other_story = FactoryGirl.create(:story, {name: 'Other Story', user: @user })
      FactoryGirl.create(:chapter, {story_id: @other_story.id, number: 1})
    @orphan_story = FactoryGirl.create(:story, {name: 'Orphaned Story'})
      @user.subscribe_to(@story, 'jarp')
      @author.subscribe_to(@story, 'aurthor', {author: true, send_email: false})
      @user.subscribe_to(@other_story, 'jarp')
  end

  after(:all) do
    Subscription.destroy_all
    Action.destroy_all
    CallToAction.destroy_all
    Vote.destroy_all
    Chapter.destroy_all
    Story.destroy_all
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
