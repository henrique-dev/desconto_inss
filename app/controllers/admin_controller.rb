class AdminController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_admin!
  layout 'admin'
  
end