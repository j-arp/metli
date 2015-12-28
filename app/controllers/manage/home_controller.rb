module Manage
  class HomeController < SuperUserController
    def index
      @active_users = User.unscoped.active.by_activity.limit(10)
      @newest_users = User.unscoped.active.order('created_at DESC').limit(10)
      @recent_stories = Story.by_activity.limit(10)
    end

    def test_mail
      NotifierMailer.welcome(active_user).deliver_now
      flash[:message] = "You should receive a test welcome email now"
      redirect_to manage_home_path
    end

    def test_workers
      
    end
  end
end
