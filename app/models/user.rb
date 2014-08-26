#encoding: utf-8
class User < ActiveRecord::Base
  has_secure_password

  before_save :set_admin
  validates :username, length: {minimum: 5, maximum: 30}, uniqueness: true
  validates :email, uniqueness: true, format: {with: /\A[a-zA-Z0-9\-]+@[a-zA-Z0-9-]+\.(org|com|cn|io|net|cc|me)\z/}
  validates :password, length: {minimum: 6}, confirmation: true

  def set_admin
    self.admin = false unless self.admin.present?
  end

  def check_password(password)
    self.authenticate(password)
  end

  def update_last_reply_time
    self.update_attribute last_reply_time: DateTime.now
  end

  def can_reply?
    (DateTime.now.to_i - self.last_reply_time.to_i) > 60
  end
end