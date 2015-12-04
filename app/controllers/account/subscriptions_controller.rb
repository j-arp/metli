module Account
  class SubscriptionsController < ApplicationController

    before_filter :find_story


    def index
      @subscriptions = active_user.subscriptions.decorate
    end

    def available
      @available_stories = active_user.available_stories
      #NotifierMailer.welcome(user).deliver_now
    end
    def add
      @subscription = active_user.subscribe_to(@story, params[:username])

      if @subscription.persisted?
        new_ids = session[:subscribed_stories].split(',')
        new_ids << @story.id
        session[:subscribed_stories] = new_ids.join(',')
        respond_to do |format|
          format.html { redirect_to account_subscriptions_path, notice: "You have been subscribed as #{params[:username]}" }
          format.json { render :show, status: :created, location: @story }
        end

      else
        flash[:message] = "You cannot subscribe to '#{@story.name}'  with username '#{params[:username]}.'"
        redirect_to account_available_stories_path
      end


    end

    def update
      @subscription = active_user.subscriptions.find(params[:id])
      @subscription.update(send_email: params[:send_email])
      flash[:message] = "Settings for #{@subscription.story.name} have been updated"
      redirect_to account_subscriptions_path
    end

    def remove
      begin
        @subscription = active_user.subscriptions.find(params[:subscription_id])
      rescue => e
        puts e
      end

      ids = session[:subscribed_stories].to_s.split(',')
      if ids.present?
        ids.reject! { |s| s == @subscription.story_id.to_s }
        session[:subscribed_stories] = ids.join(',')
      end
      @subscription.destroy if @subscription
      redirect_to account_subscriptions_path
    end

    private

    def subscription_params
      params.require(:subscription).permit(:story_id, :username)
    end
  end
end
