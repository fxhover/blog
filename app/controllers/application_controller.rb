#encoding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :is_logined?, :current_user_is_admin?, :get_categories_options, :current_user_can_star?,
                :current_user_can_edit_comment?, :markdown_parser

  rescue_from Exception, with: :error_500 unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound, with: :error_404 unless Rails.env.development?

  before_filter :current_user

  def current_user
    @current_user = nil
    if session[:user_id].present?
      @current_user = User.find(session[:user_id])
      redirect_to logout_path(referer) unless @current_user
    end
    @current_user
  end

  def current_user_is_admin?
    @current_user && @current_user.admin
  end

  def current_user_can_star?(article)
    return false unless @current_user
    !article.article_stars.find_by(user_id: @current_user.id).present?
  end

  def current_user_can_edit_comment?(comment)
    return false unless @current_user
    comment.user_id == @current_user.id
  end

  def get_categories_options
    options = []
    Category.order('articles_count desc').each {|c| options << [c.name, c.id]}
    options
  end

  def markdown_parser(content)
    markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML, autolink: true, tables: true
    markdown.render content
  end

  def referer
    request.env['HTTP_REFERER'] || root_path
  end

  def is_logined?
    session[:user_id].present? && session[:user_id]
  end

  def require_login
    redirect_to root_path unless is_logined?
  end

  def error_500
    render file: File.join(Rails.root, 'public/500.html'), status: 500, layout: false
  end

  def error_404
    render file: File.join(Rails.root, 'public/404.html'), status: 404, layout: false
  end
end
