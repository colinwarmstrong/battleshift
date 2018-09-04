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

    it 'they cannot login without inputting invalid info' do
      user = create(:user)

      visit root_path

      click_on 'Login'

      fill_in :email, with: user.email
      fill_in :password, with: 'invalid_password'
      click_on 'Login'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Invalid login info, please try again.')
    end

    it 'they can logout' do
      user = create(:user)

      visit root_path

      click_on 'Login'

      fill_in :email, with: user.email
      fill_in :password, with: 'password'
      click_on 'Login'

      expect(current_path).to eq(dashboard_path)

      click_on 'Logout'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Successfully logged out.')
    end
  end
end
