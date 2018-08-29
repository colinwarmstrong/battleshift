require 'rails_helper'

describe 'A registered user' do
  context 'visits /' do
    it 'they can login' do
      user = create(:user)

      visit root_path

      click_on 'Login'

      fill_in :email, with: user.email
      fill_in :password, with: 'password'
      click_on 'Login'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as #{user.name }")
    end
  end
end
