class User < ActiveRecord::Base
  validates_presence_of :name, :username, :email, :password
  has_secure_password
  belongs_to :user
end
