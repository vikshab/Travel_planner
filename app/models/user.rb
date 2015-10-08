class User < ActiveRecord::Base
  before_save { self.email = email.downcase}
  validates :user_name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /@/
  has_secure_password
end
