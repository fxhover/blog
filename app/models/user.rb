#encoding: utf-8
class User < ActiveRecord::Base
  has_secure_password
  validates :username, length: {minimum: 5, maximum: 30}, uniqueness: true
  validates :email, uniqueness: true, format: {with: /\A[a-zA-Z0-9\-]+@[a-zA-Z0-9-]+\.(org|com|cn|io|net|cc|me)\z/}
  validates :password, length: {minimum: 6}, confirmation: true

  def check_password(password)
    self && self.authenticate(password)
  end

end