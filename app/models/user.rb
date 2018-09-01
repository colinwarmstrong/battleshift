class User < ApplicationRecord
  has_secure_password
  has_secure_token :token
  validates :password, confirmation: {case_sensitive: true}
  validates_presence_of :email, :name, :password_digest
  validates_uniqueness_of :email
end
