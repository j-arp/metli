module Manage
  class HomeController < SuperUserController
    def index
      @active_users = User.unscoped.active.by_activity.limit(10)
      @newest_users = User.unscoped.active.order('created_at DESC').limit(10)
      @recent_stories = Story.by_activity.limit(10)
    end
end
end
