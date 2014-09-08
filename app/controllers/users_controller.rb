#encoding: utf-8
class UsersController < ApplicationController
  def register
    @user = User.new
    render 'register', layout: 'register'
  end

  def register_confirm
    @user = User.new params.require(:user).permit(:username,:email,:password,:password_confirmation)
    if @user.save
      #to_login @user
      session[:wait_active_email] = @user.email
      redirect_to send_active_mail_users_path
    else
      render 'register', layout: 'register'
    end
  end

  def login
    return redirect_to(login_path(from: referer)) unless params[:from].present?
    @user = User.new
    render 'login', layout: 'register'
  end

  def login_confirm
    @user = User.find_by username: params[:user][:username]
    unless @user.activation?
      session[:wait_active_email] = @user.email
      flash.now[:error] = "用户还没有激活，<a href='#{send_active_mail_users_path}'>点此</a>发送激活邮件。"
      return render 'login', layout: 'register'
    end
    if @user && @user.check_password(params[:user][:password])
      to_login @user
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

  def send_active_mail
    @result = {status: true, message: ''}
    if session[:wait_active_email]
      wait_user = User.find_by email: session[:wait_active_email]
      if wait_user.activation?
        flash[:success] = '您的账号已经激活，请登录'
        return redirect_to login_path
      end
      if wait_user.present?
        token = UserActive.generate_token
        active = UserActive.new user_id: wait_user.id, type_name: 'Active', token: token
        url = File.join(Settings.blog.domain, "users/activation?token=#{token}")
        if active.save && UserMailer.auth_mail(session[:wait_active_email], url).deliver
          @result[:status] = true
          @result[:message] = session[:wait_active_email]
        end
      end
    end
  end

  def activation
    active = UserActive.find_by token: params[:token]
    if active && !active.used?
      user = User.find active.user_id
      user.activation = 1
      active.used = 1
      if user.save && active.save
        flash[:success] = '激活成功，请登录'
        redirect_to login_path
      else
        flash[:error] = '激活失败，请重试，如果还不能激活，请联系管理员'
        redirect_to login_path
      end
    else
      flash[:error] = 'token不存在'
      redirect_to root_path
    end
  end

  def forget_password
    render 'forget_password', layout: 'register'
  end

  def forget_password_confirm

  end

  protected

  def to_login(user)
    session[:user_id] = user.id
  end
end