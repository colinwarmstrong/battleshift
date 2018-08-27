class ActivationController < ApplicationController
  def index
    @user = User.find_by_email(params[:user_email])
    @user.update(activated?: true)
    redirect_to dashboard_path
  end
end