user = "ec2-user"
master_hsot = "35.164.75.182"
hosts = [
  "ec2-35-164-75-182.us-west-2.compute.amazonaws.com"
]

set :rails_env, "production"
set :unicorn_rack_env, 'production'
set :migration_role, :db
set :keep_assets, 2
set :pty, false

server master_hsot, user: user, roles: %w{app web db}

hosts.each do |host|
  server host, user: user, roles: %w{app web}
end

set :ssh_options, {
  keys: %w(~/.ssh/rorensu.pem),
  forward_agent: true,
  auth_methods: %w(publickey)
}
