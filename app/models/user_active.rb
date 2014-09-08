#encoding: utf-8
class UserActive < ActiveRecord::Base
  before_save :set_used

  def set_used
    self.used = 0 if self.used.nil?
  end

  class << self
    def generate_token
      SecureRandom.urlsafe_base64 + Time.now.to_i.to_s
    end
  end
end