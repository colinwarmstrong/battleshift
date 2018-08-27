class ActivationMailer < ApplicationMailer
  def activation(user)
    @user = user
    # @url = activation_url
    mail(to: user.email, subject: "Battleshift account activation")
  end
end
