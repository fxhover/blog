#encoding: utf-8
class CommentsController < ApplicationController
  before_filter :article, only: [:create, :edit, :update, :destroy]

  def create

  end

  def article
    @article = Article.find params[:article_id]
  end
end