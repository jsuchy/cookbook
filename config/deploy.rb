default_environment['PATH'] = '/usr/lib/ruby/gems/1.8/bin:/home/jsuchy/.gems/bin:/usr/local/bin:/usr/bin:/bin'

require "bundler/capistrano"

default_run_options[:pty] = true

set :user, 'jsuchy'
set :domain, 'cookbook.jimandamelia.com'
set :application, 'cookbook'
set :applicationdir, "/home/#{user}/#{domain}"

set :scm, :subversion
set :scm_verbose, true
set :repository,  "http://www.jimandamelia.com/cookbook_svn/"


role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :deploy_to, applicationdir
set :deploy_via, :export

set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
