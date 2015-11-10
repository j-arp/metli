module Account
  class SubscriptionsController < ApplicationController

    before_filter :find_story


    def index
    end

    def add
      active_user.subscribe_to(@story, params[:username])

      respond_to do |format|
        if @story.save
          format.html { redirect_to account_path, notice: "You have been subscribed as #{params[:username]}" }
          format.json { render :show, status: :created, location: @story }
        else
          format.html { render :new }
          format.json { render json: params, status: :unprocessable_entity }
        end
      end
    end

    def remove
      @subscription = Subscription.find(params[:subscription_id])
      @subscription.destroy
      redirect_to account_path
    end

    private

    def subscription_params
      params.require(:subscription).permit(:story_id, :username)
    end
  end
end
