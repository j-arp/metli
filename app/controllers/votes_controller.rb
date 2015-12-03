class VotesController < ActiveUsersController
  before_action :set_story
  before_action :set_chapter

  def create
    @vote = @chapter.actions.find(params[:action_id]).votes.where(user: active_user).first_or_initialize

    if @vote.save
      active_user.subscriptions.find_by(story:@story).update(last_voted_chapter_number: @chapter.number)
    end

    flash[:message] = "Thanks for voting!"
    redirect_to read_chapter_path(@chapter.number)
  end

  def destroy
  end


  def set_chapter
    @chapter = @story.chapters.find(params[:chapter_id])
  end

  def set_story
    @story || @story = Story.find(session[:current_story_id])
  end
end
