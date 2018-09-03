require "rails_helper"

describe 'Activation Mailer' do
  it 'Users can activate their account from link in activation email' do
    user = create(:user)

    visit activation_path(user_token: user.token)

    expect(User.find(user.id).activated).to eq(true)
  end
end
