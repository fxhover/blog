# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'blog'
set :repo_url, 'https://github.com/fxhover/blog.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

server '127.0.0.1', user: 'fangxiang', roles: %w{web app db}
set :use_sudo, true

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/blog'

# Default value for :scm is :git
set :scm, :git
set :branch, 'master'

# Default value for :log_level is :debug
set :log_level, :debug

# Rvm
set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '2.1.2'      # Defaults to: 'default'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/blog.yml', 'config/unicorn.rb'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/bundle'

# Default value for default_env is {}
#set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Rails environment
set :rails_env, 'production'

# Unicorn config file path
set :unicorn_config_path, 'config/unicorn.rb'

set :enable_ssl, false

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:reload'
  end
end