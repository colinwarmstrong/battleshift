FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { 'John Doe' }
    password_digest { BCrypt::Password.create('password') }
    token { ENV['BATTLESHIFT_API_KEY'] }
  end
end
