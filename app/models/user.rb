class User < ActiveRecord::Base
  has_many :trips
  # before_save { self.email = email.downcase}
  validates :user_name, presence: true, uniqueness: { case_sensitive: false }
  # validates :email, uniqueness: { case_sensitive: false }, format: /@/
  # has_secure_password

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
      user.user_name = auth["info"]["name"]
    end
  end
end
