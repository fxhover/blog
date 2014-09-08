require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    #Set autoload path
    config.autoload_paths += %W(#{config.root}/lib)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = "zh-CN"

    BLOG_CONFIG = YAML.load_file(File.join(Rails.root, 'config/blog.yml'))[Rails.env.to_s]
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default :charset => "utf-8"
    config.action_mailer.default_url_options = {host: BLOG_CONFIG['blog']['domain']}
    config.action_mailer.smtp_settings = {
        address: BLOG_CONFIG['mailer']['address'],
        port: BLOG_CONFIG['mailer']['port'],
        user_name: BLOG_CONFIG['mailer']['user_name'],
        password: BLOG_CONFIG['mailer']['password'],
        authentication: 'plain',
        enable_starttls_auto: false
    }
  end
end
