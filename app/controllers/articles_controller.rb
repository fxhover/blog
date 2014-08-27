#encoding: utf-8
class ArticlesController < ApplicationController
  before_filter :check_current_user_is_admin, only: [:new, :create, :edit, :update]
  before_filter :article, only: [:show, :edit, :update, :destroy]

  def index
    res = Article
    order = 'updated_at desc'
    if params[:sort].present?
      order = case params[:sort]
                when 'star'
                  'star_count desc'
                when 'comments'
                  'comments_count desc'
                else
                  'updated_at desc'
              end
    end
    if params[:c].present?
      category = Category.find params[:c]
      res = res.where("category_id=#{category.id}") if category
    end
    res = res.where("title like ?", "%#{params[:keyword]}%") if params[:keyword].present?
    @articles = res.order(order).page(params[:page]).per(2)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new params.require(:article).permit(:title, :tags, :source, :content)
    @article.user_id = @current_user.id
    if params[:article].present? && params[:article][:category_id].present?
      @article.category_id = params[:article][:category_id]
    elsif params[:article].present? && params[:article][:category_name].present?
      category = Category.find_or_create params[:article][:category_name]
      @article.category_id = category.id
    end
    if @article.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show

  end

  def star

  end

  protected

  def check_current_user_is_admin
   redirect_to root_path unless (@current_user && @current_user.admin)
  end

  def article
    @article = Article.find params[:id]
  end
end