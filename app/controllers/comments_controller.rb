#encoding: utf-8
class CommentsController < ApplicationController
  before_filter :article, only: [:create, :edit, :update, :destroy]
  before_filter :require_login
  before_filter :get_comment, only: [:edit, :update, :destroy]

  def create
    @result = {status: true, message: ''}
    @comment = @article.comments.new content: params[:article_comment][:content]
    @comment.user_id = @current_user.id
    if @comment.save
      @result[:status] = true
    else
      @result[:message] = '发表评论失败'
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @result = {status: false, message: ''}
    if params[:article_comment].present? && params[:article_comment][:content].present?
      @comment.content = params[:article_comment][:content]
      if @comment.save
        @result[:status] = true
      else
        @result[:message] = '编辑评论失败'
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @result = {status: false, message: ''}
    if @comment.destroy
      @result[:status] = true
    else
      @result[:message] = '删除评论失败'
    end
    respond_to do |format|
      format.js
    end
  end

  protected

  def article
    @article = Article.find params[:article_id]
  end

  def get_comment
    @comment = @article.comments.find params[:id]
  end
end