#encoding: utf-8
class Article < ActiveRecord::Base
  attr_accessor :category_name
  belongs_to :category, counter_cache: 'articles_count'

  validates :title, length: {minimum: 10, maximum: 50}
  validates :tags, presence: true
  validates :source, allow_blank: true, format: {with: /[a-zA-Z0-9-]+\.[a-zA-Z0-9]+/}
  validates :content, length: {minimum: 10}

  validate :validate_category

  def validate_category
    errors.add(:category_id, '分类不正确') unless Category.find(self.category_id)
  rescue
    errors.add(:category_id, '分类不正确')
    return false
  else
    return true
  end

end