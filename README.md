# Capistrano::ndenv

This gem provides idiomatic ndenv support for Capistrano 3.x (and 3.x *only*).

*NOTE*: This gem is a rip-off of https://github.com/capistrano/rbenv - give them the credit.

# Why you might want it?

If you need to execute node or npm from capistrano and you prefer ndenv over nvm

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano', '~> 3.1'
    gem 'capistrano-ndenv', '~> 1.0'

And then execute:

    $ bundle install

## Usage

    # Capfile
    require 'capistrano/ndenv'


    # config/deploy.rb
    set :ndenv_type, :user # or :system, depends on your ndenv setup
    set :ndenv_node, 'v0.10.31'
    set :ndenv_prefix, "NDENV_ROOT=#{fetch(:ndenv_path)} NDENV_VERSION=#{fetch(:ndenv_node)} #{fetch(:ndenv_path)}/bin/ndenv exec"
    set :ndenv_map_bins, %w{npm node} # default
    set :ndenv_roles, :all # default value

If your ndenv is located in some custom path, you can use `ndenv_custom_path` to set it.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
