require 'rails_helper'

describe 'A guest user' do
  context 'visits /' do
    let(:email)    { 'test@email.com' }
    let(:name)     { 'John Doe' }
    let(:password) { 'password123' }

    it 'they can register for a new account' do
      visit root_path

      click_on 'Register'

      expect(current_path).to eq('/register')

      fill_in :user_email, with: email
      fill_in :user_name, with: name
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password

      click_on 'Submit'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as #{name}")
      expect(page).to have_content('This account has not yet been activated. Please check your email.')
    end

    it 'they cannot create an account without matching password and password confirmation fields' do
      visit root_path

      click_on 'Register'

      expect(current_path).to eq(registration_path)

      fill_in :user_email, with: email
      fill_in :user_name, with: name
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: 'password124'

      click_on 'Submit'

      expect(current_path).to eq(users_path)
      expect(page).to have_content('Invalid information, please try again.')
    end
  end
end
