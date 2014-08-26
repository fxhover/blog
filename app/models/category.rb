#encoding: utf-8
class Category < ActiveRecord::Base
  has_many :articles

  class << self
    def find_or_create(name)
      category = self.find_by name: name
      unless category
        category = Category.new name: name
        category.save!
      end
      category
    end
  end
end