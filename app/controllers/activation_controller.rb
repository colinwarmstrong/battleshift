class ActivationController < ApplicationController
  def index
    @user = User.find_by_email(params[:user_email])
    @user.update(activated?: true)
    session[:user_id] = @user.id
    flash[:notice] = "Thank you! Your account has been activated."
    redirect_to dashboard_path
  end
end