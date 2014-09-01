#encoding: utf-8
module ApplicationHelper
  def avatar(user)
    user.avatar.present? ? image_tag(user.avatar) : (gravatar_image_tag user.email, alt: user.username)
  end

  def avatar_url(user)
    user.avatar.present? ? user.avatar : (gravatar_image_url user.email, alt: user.username)
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

  def blog_title
    blog = BlogInfo.first
    blog.present? ? blog.blog_title : 'Blog'
  end
end
