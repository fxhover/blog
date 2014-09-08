#encoding: utf-8
class UserMailer < ActionMailer::Base
  helper ApplicationHelper

  default from: Settings.mailer.user_name

  def auth_mail(email, url)
    @url  = url
    mail( :subject => "用户邮箱激活邮件",
          :to => email,
          :date => Time.now
    )
  end
end
