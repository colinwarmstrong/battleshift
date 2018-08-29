require "rails_helper"

RSpec.describe ActivationMailer, type: :mailer do
  it 'Users can activate their account from link in activation email' do
    user = create(:user)

    visit activation_url(user_token: user.token)

    expect(User.find(user.id).activated).to be(true)
  end
end
