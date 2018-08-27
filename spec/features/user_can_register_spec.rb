require 'rails_helper'

describe 'A guest user' do
  context 'visits /' do
    it 'they can register for a new account' do
      visit root_path

      click_on 'Register'

      expect(current_path).to eq('/register')

      name = 'John Doe'

      fill_in :email_address, with: 'test@email.com'
      fill_in :name, with: name
      fill_in :password, with: 'password123'
      fill_in :password_confirmation, with: 'password123'

      click_on 'Submit'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Logged in as #{name}")
      expect(page).to have_content('This account has not yet been activated. Please check your email.')
    end
  end
end
