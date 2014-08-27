#encoding: utf-8
class Article < ActiveRecord::Base
  attr_accessor :category_name
  belongs_to :category, counter_cache: 'articles_count'
  belongs_to :user
  has_many :article_stars
  has_many :article_views
  has_many :comments, class_name: 'ArticleComment'

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

  def add_view(ip, current_user, param_string)
    return false if (self.article_views.where("created_at >= '#{DateTime.now - 10.minute}' and ip='#{ip}'").count > 0)
    view = self.article_views.new ip: ip, param_string: param_string
    view.user_id = current_user.id if current_user
    view.save
  end

end