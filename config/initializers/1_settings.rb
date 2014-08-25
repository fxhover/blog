#encoding: utf-8
class Settings < Settingslogic
  source "#{Rails.root}/config/blog.yml"
  namespace Rails.env
end