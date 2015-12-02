class StoryController < ActiveUsersController\

  def index
    # puts session[:subscribed_stories].inspect
    # puts session[:current_story_id].inspect

    if session[:current_story_id]
      set_current_story
    elsif session[:subscribed_stories].nil?
      flash[:message] = "you have not subscribed to any stories yet"
      redirect_to account_path
    else
      redirect_to choose_story_path
    end
  end

  def choose
    @subscribed_stories = Story.where(id: session[:subscribed_stories].split(','))
  end

  def set_current_story_id
    session[:current_story_id] = params[:id] if params[:id]
    session[:current_story_id] = Story.find_by_permalink(params[:story]).id if params[:story]
    redirect_to story_path
  end

  def chapter
    set_current_story
    @active_user = active_user
    @chapter = @current_story.chapters.find_by_number(params[:number])
    @call_to_action = CallToActionDecorator.new(@chapter.call_to_action)
    @allow_voting = allow_voting?

  end


  private

  def allow_voting?
    puts "++ is voting closed? #{ (@chapter.vote_ends_on < Time.now ) }"
    return false if @chapter.votes.select { | v | v.user_id == active_user.id }.present?
    return false if @chapter.vote_ends_on < Time.now
    return true
  end

  def set_current_story
    @current_story || @current_story = Story.find(session[:current_story_id])
  end
end
