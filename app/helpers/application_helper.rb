#encoding: utf-8
module ApplicationHelper
  def avatar(user)
    gravatar_image_tag user.email, alt: user.username #, gravatar: {default: '/gavatar.jpg'}
  end

  def get_categories
    Category.order('articles_count desc')
  end

  def get_tags(article)
    tags = article.tags || ''
    tags.split(',')
  end

  def get_articles_count
    Article.count
  end
end
