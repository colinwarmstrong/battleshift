class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:notice] = 'Invalid login info, please try again.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Successfully logged out.'
    redirect_to root_path
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
