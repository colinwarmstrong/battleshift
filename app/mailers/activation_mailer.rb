class ActivationMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def activation(user)
    @user = user
    mail(to: user.email, subject: "Battleshift account activation")
  end
end
