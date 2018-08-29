class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:notice] = 'Invalid login info, please try again.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart] = nil
    flash[:notice] = 'Successfully logged out.'
    redirect_to root_path
  end
end
