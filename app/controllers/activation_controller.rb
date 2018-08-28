class ActivationController < ApplicationController
  def index
    user = User.find_by_email(params[:user_email])
    user.activated = true
    user.save
    flash[:notice] = "Thank you! Your account has been activated."
    session[:user_id] = user.id
    redirect_to dashboard_path
  end
end
