module Manage
  class HomeController < SuperUserController
    def index
      @active_users = User.by_activity.limit(10)
      @newest_users = User.unscoped.where(deleted: false).order('created_at DESC').limit(10)
      @recent_stories = Story.by_activity.limit(10)
    end
end
end
