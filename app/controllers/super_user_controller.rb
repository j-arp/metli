class SuperUserController < ActiveUsersController
  before_action :require_super_user_login

end
