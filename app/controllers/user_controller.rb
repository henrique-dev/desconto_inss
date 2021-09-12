class UserController < ActionController::Base
  before_action :authenticate_user!
  layout 'user'
  
end