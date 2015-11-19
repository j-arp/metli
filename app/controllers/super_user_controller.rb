class ActiveUserController < ActiveUserController
  before_action :require_super_user_login

end
