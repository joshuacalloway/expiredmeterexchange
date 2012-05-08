class AdminController < ApplicationController
  http_basic_authenticate_with :name => "frodo", :password => "thering"

  def send_welcome_email
    UserMailer.welcome_email(nil).deliver
    redirect_to admin_path
  end
end
