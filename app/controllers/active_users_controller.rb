class ActiveUsersController < ApplicationController
  before_action :require_login
  before_action :set_active_user


  def set_active_user
    @active_user = active_user
  end

end
