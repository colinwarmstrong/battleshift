class RegistrationController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      ActivationMailer.activation(@user).deliver_now
      redirect_to dashboard_path
    else
      flash[:notice] = 'Invalid information, please try again.'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
