#!/usr/bin/env puma
# start puma with:
# RACK_ENV=production bundle exec puma -C ./config/puma.rb
if ENV['RACK_ENV'] == "production"
# Change to match your CPU core count
workers 1

# Min and Max threads per worker
threads 1, 6

daemonize true
app_dir = '/var/www/aquiub'
shared_dir = "#{app_dir}/shared"

# Default to production
padrino_env = ENV['RACK_ENV'] || "production"
environment padrino_env

# Set up socket location
bind "unix://#{shared_dir}/sockets/puma.sock"

# Logging
stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
activate_control_app
end
