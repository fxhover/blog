#encoding: utf-8
class CommentsController < ApplicationController
  before_filter :article, only: [:create, :edit, :update, :destroy]
  before_filter :require_login
  before_filter :get_comment, only: [:update, :destroy]

  def create
    @comment = @article.comments.new content: params[:article_comment][:content]
    @comment.user_id = @current_user.id
    unless @comment.save
      flash[:error] = '评论失败'
    end
    redirect_to article_path(@article)
  end

  def update

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