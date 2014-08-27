#encoding: utf-8
class CommentsController < ApplicationController
  before_filter :article, only: [:create, :edit, :update, :destroy]
  before_filter :require_login

  def create
    @comment = @article.comments.new content: params[:article_comment][:content]
    @comment.user_id = @current_user.id
    unless @comment.save
      flash[:error] = '评论失败'
    end
    redirect_to article_path(@article)
  end

  def article
    @article = Article.find params[:article_id]
  end
end