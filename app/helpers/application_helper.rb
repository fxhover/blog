#encoding: utf-8
module ApplicationHelper
  def avatar(user)
    gravatar_image_tag user.email, alt: user.username, gravatar: {default: 'http://www.gravatar.com/avatar/0c821f675f132d790b3f25e79da739a7'}
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
