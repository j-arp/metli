module Account
  class SubscriptionsController < ApplicationController

    before_filter :find_story


    def index
      @subscriptions = active_user.subscriptions
      #NotifierMailer.welcome(user).deliver_now
    end

    def add
      active_user.subscribe_to(@story, params[:username])
      session[:subscribed_stories] =+ @story.id
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

    def update
      puts params
      @subscription = active_user.subscriptions.find(params[:id])
      @subscription.update(send_email: params[:send_email])
      flash[:message] = "Settings for #{@subscription.story.name} have been updated"
      redirect_to account_subscriptions_path
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
