class ActivationController < ApplicationController
  def index
    user = User.find_by_token(params[:user_token])
    user.update_attributes!(activated: true)
    flash[:notice] = "Thank you! Your account has been activated."
    session[:user_id] = user.id
    redirect_to dashboard_path
  end
end
