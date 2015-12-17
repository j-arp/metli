class Manage::SubscribersController < ActiveUsersController
  before_action :set_subscription

  def promote
    respond_to do |format|
      if @subscription.update(privileged: true)
        format.html { redirect_to manage_story_path(@subscription.story.id), notice: 'User was successfully updated.' }
        format.json { render json: @subscription, status: :ok }
        format.js { render json: @subscription, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
        format.js { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def relegate
    respond_to do |format|
      if @subscription.update(privileged: params[:privileged])
        format.html { redirect_to manage_story_path(@subscription.story.id), notice: 'User was successfully updated.' }
        format.json { render json: @subscription, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end  end

  private

  def set_subscription
    @story = Story.find_by(id: params[:story_id])
    @subscription = Subscription.find_by(user_id: params[:user_id], story: @story )
    return @subscription
  end
end
