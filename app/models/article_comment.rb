#encoding: utf-8
class ArticleComment < ActiveRecord::Base
  belongs_to :article, counter_cache: 'comments_count'

  validate :content, length: {minimum: 10}
end