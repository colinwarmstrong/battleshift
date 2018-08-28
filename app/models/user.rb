class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :name, :password_digest
  validates_uniqueness_of :email
  validates :password, confirmation: {case_sensitive: true}
end
