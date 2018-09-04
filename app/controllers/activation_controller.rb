class ActivationController < ApplicationController
  def index
    user = User.find_by_token(activation_params[:user_token])
    user.update(activated: true)
    session[:user_id] = user.id
    flash[:notice] = "Thank you! Your account has been activated."
    redirect_to dashboard_path
  end

  private

  def activation_params
    params.permit(:user_token)
  end
end
