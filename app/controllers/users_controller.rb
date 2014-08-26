#encoding: utf-8
class UsersController < ApplicationController
  def register
    @user = User.new
    render 'register', layout: 'register'
  end

  def register_confirm
    @user = User.new params.require(:user).permit(:username,:email,:password,:password_confirmation)
    if @user.save
      login @user
      redirect_to root_path
    else
      render 'register', layout: 'register'
    end
  end

  def login
    redirect_to login_path(from: referer) unless params[:from].present?
    @user = User.new
    render 'login', layout: 'register'
  end

  def login_confirm
    @user = User.find_by username: params[:user][:username]
    if @user && @user.check_password(params[:user][:password])
      login @user
      @user.update_attribute :last_login_time, DateTime.now
      redirect_to (params[:from].present? ? params[:from] : root_path)
    else
      flash[:error] = '用户名或密码错误'
      render 'login', layout: 'register'
    end
  rescue
    flash[:error] = '用户名或密码错误'
    render 'login', layout: 'register'
  end

  def logout
    session[:user_id] = nil
    redirect_to referer
  end

  protected

  def login(user)
    session[:user_id] = user.id
  end
end