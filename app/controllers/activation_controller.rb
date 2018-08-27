class ActivationController < ApplicationController
  def index
    @user = User.find_by_email(params[:email])
  end
end