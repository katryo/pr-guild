class AdminController < ApplicationController
  http_basic_authenticate_with :name => "admin", :password => ENV["admin_pw"] if Rails.env.production?

  def index
  end

  def make_users_points_half
  end

  def make_users_points_double
  end
  
  def make_the_users_points_change
    params[:username]
    redirect_to admin_path
  
  end

end
