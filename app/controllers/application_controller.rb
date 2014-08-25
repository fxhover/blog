#encoding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :is_logined?

  rescue_from Exception, with: :error_500 unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound, with: :error_404 unless Rails.env.development?

  def current_user
    @current_user = nil
    @current_user = User.find(session[:user_id]) if session[:user_id].present?
  end

  def is_logined?
    session[:user_id].present? && session[:user_id]
  end

  def error_500
    render file: File.join(Rails.root, 'public/500.html'), status: 500, layout: false
  end

  def error_404
    render file: File.join(Rails.root, 'public/404.html'), status: 404, layout: false
  end
end
