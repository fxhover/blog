#encoding: utf-8
class ArticleStar < ActiveRecord::Base
  belongs_to :article, counter_cache: 'star_count'

end