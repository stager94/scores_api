set :application, 'scores_api'
set :deploy_user, 'root'

set :scm, :git
set :repo_url, 'git@github.com:stager94/scores_api.git'

set :keep_releases, 5
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


set :format, :pretty
set :log_level, :debug


# set :ssh_options, :forward_agent => true

# # set :linked_files, %w{config/database.yml config/secrets.yml config/unicorn.rb config/application.yml config/sidekiq.yml public/sitemap.xml public/robots.txt}
# # set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system}

# set :sidekiq_config, -> { File.join(shared_path, 'config', 'sidekiq.yml') }



# # Default branch is :master
# # ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# # Default deploy_to directory is /var/www/my_app_name
# # set :deploy_to, '/var/www/my_app_name'

# # Default value for :scm is :git
# # set :scm, :git

# # Default value for :format is :airbrussh.
# # set :format, :airbrussh

# # You can configure the Airbrussh format using :format_options.
# # These are the defaults.
# # set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# # Default value for :pty is false
# # set :pty, true

# # Default value for :linked_files is []
# # append :linked_files, 'config/database.yml', 'config/secrets.yml'

# # Default value for linked_dirs is []
# # append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# # Default value for default_env is {}
# # set :default_env, { path: "/opt/ruby/bin:$PATH" }

# # Default value for keep_releases is 5
# # set :keep_releases, 5
