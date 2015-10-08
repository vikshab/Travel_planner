class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /@/
end
