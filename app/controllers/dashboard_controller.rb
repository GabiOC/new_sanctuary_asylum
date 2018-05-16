class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    redirect_to admin_path(current_user.preferred_community) if current_user.admin?
  end

end