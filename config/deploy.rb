require "bundler/capistrano"

set :application, "sanpo.cc"
set :repository,  "git@github.com:gueorgui/sanpo.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache

ssh_options[:forward_agent] = true

role :web, "dev.sanpo.cc"                          # Your HTTP server, Apache/etc
role :app, "dev.sanpo.cc"                          # This may be the same as your `Web` server
role :db,  "dev.sanpo.cc", :primary => true       # This is where Rails migrations will run

set :user, "sanpo"
set :use_sudo, false

set :deploy_to, "/home/sanpo/sanpo.cc"
set :shared_path, "/home/sanpo/sanpo.cc/shared"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink shared config files and folders for each release"
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/photos #{current_release}/public/system"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
