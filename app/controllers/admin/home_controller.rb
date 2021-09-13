class Admin::HomeController < AdminController
  def index    
    @users = User.all
    @ranges = User.calculate_ranges
  end
end
