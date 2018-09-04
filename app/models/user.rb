class User < ApplicationRecord
  validates_presence_of :email, :name, :password_digest
  validates_uniqueness_of :email
  validates :password, confirmation: {case_sensitive: true}
  has_secure_password
  has_secure_token :token
end
