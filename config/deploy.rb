require 'capistrano_colors'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))  # Add RVM's lib directory to the load path.
require "rvm/capistrano"                                # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ruby-1.9.2-p290@sanpo'           # Or whatever env you want it to run in.
set :rvm_type, :user  # Copy the exact line. I really mean :user here

set :bundle_roles, [:app]
require "bundler/capistrano"

require "delayed/recipes"
set :rails_env, "production" # Added for delayed job

set :application, "sanpo.cc"
set :repository,  "git@github.com:gueorgui/sanpo.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :normalize_asset_timestamps, false

ssh_options[:forward_agent] = true

role :web, "sanpo.cc"                          # Your HTTP server, Apache/etc
role :app, "sanpo.cc"                          # This may be the same as your `Web` server
role :db,  "sanpo.cc", :primary => true       # This is where Rails migrations will run

set :user, "sanpo"
set :use_sudo, false

set :deploy_to, "/home/sanpo/sanpo.cc"
set :shared_path, "/home/sanpo/sanpo.cc/shared"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    run "rake precreate_profiles"
  end

  desc "Symlink shared config files and folders for each release"
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/photos #{current_release}/public/system"
#    run "cd #{current_release} && bundle exec rake assets:precompile"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'

# Delayed job
before "deploy:restart", "delayed_job:stop"
after  "deploy:restart", "delayed_job:start"
after "deploy:stop",  "delayed_job:stop"
after "deploy:start", "delayed_job:start"
