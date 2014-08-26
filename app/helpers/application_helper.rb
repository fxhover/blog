#encoding: utf-8
module ApplicationHelper
  def avatar(user)
    gravatar_image_tag user.email, alt: user.username, gravatar: {default: 'http://www.gravatar.com/avatar/0c821f675f132d790b3f25e79da739a7'}
  end
end
