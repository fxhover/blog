#encoding: utf-8
class BlogsController < ApplicationController
  before_filter :require_login, only: [:set, :set_userinfo, :upload_img, :set_blog, :update_blog, :change_password, :update_password]

  def index
    @articles = Article.order('updated_at desc').limit(10)
    @new_comments = ArticleComment.order('updated_at desc').limit(10)
  end

  def set

  end

  def set_userinfo
    user = User.find @current_user.id
    user.nick_name = params[:user][:nick_name] if params[:user][:nick_name].present?
    begin
      if params[:user][:avatar].present?
        upload_info = upload_picture params[:user][:avatar]
        user.avatar = "/images/#{upload_info[:real_file_name]}"
      end
    rescue UploadException => e
      flash.now[:error] = e.message
      render 'set'
    else
      if user.save
        redirect_to set_blogs_path
      else
        flash.now[:error] = user.errors.full_messages.first
        render 'set'
      end
    end
  end

  def set_blog
    @blog = BlogInfo.first
    @blog = BlogInfo.new unless @blog
  end

  def update_blog
    param_hash = params.require(:blog).permit(:name, :blog_title, :email, :description)
    @blog = BlogInfo.first
    if @blog.present?
      result = @blog.update_attributes param_hash
    else
      @blog = BlogInfo.new param_hash
      result = @blog.save
    end
    if result
      redirect_to set_blogs_path
    else
      render 'set_blog'
    end
  end

  def about
    @blog = BlogInfo.first
  end

  def change_password

  end

  def update_password
    @user = User.find @current_user.id
    if @user.check_password(params[:user][:old_password])
      @user.password = params[:user][:password] || ''
      @user.password_confirmation = params[:user][:password_confirmation] || ''
      if @user.save
        flash[:success] = '修改密码成功，请重新登录'
        redirect_to login_path
      else
        render 'change_password'
      end
    else
      flash.now[:error] = '原密码错误'
      render 'change_password'
    end
  end

  def upload_img
    @result = {status: false, message: '', text_id: params[:upload][:text_id] || ''}
    begin
      if params[:upload].present? && params[:upload][:img].present? && remotipart_submitted?
        upload_info = upload_picture params[:upload][:img]
        @result[:status] = true
        @result[:message] = "![#{upload_info[:file_name]}](/images/#{upload_info[:real_file_name]})"
      end
    rescue UploadException => e
      @result[:message] = e.message
    end
    respond_to do |format|
      format.js
    end
  end

  def preview
    result = {status: false, message: ''}
    if params[:content]
      result[:status] = true
      result[:message] = ActionController::Base.helpers.sanitize(markdown_parser(params[:content]))
    end
    render json: result.to_json
  end

  protected

  def upload_picture(file)
    upload_path = File.join Rails.root, 'public/images'
    upload = SimpleFileupload.new upload_path:upload_path, max_size: 1024*1024*2, type: 'image'
    upload_info = upload.upload file
  end
end