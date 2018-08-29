FactoryBot.define do
  factory :user do
    email { 'test@email.com' }
    name { 'John Doe' }
    password_digest { BCrypt::Password.create('password') }
    token { '123456789' }
  end
end
