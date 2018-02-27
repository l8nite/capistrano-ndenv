namespace :ndenv do
  task :validate do
    on release_roles(fetch(:ndenv_roles)) do
      ndenv_node = fetch(:ndenv_node)
      if ndenv_node.nil?
        error "ndenv: ndenv_node is not set"
        exit 1
      end

      unless test "[ -d #{fetch(:ndenv_node_dir)} ]"
        error "ndenv: #{ndenv_node} is not installed or not found in #{fetch(:ndenv_node_dir)}"
        exit 1
      end
    end
  end

  task :map_bins do
    SSHKit.config.default_env.merge!({ ndenv_root: fetch(:ndenv_path), ndenv_version: fetch(:ndenv_node) })
    ndenv_prefix = fetch(:ndenv_prefix, proc { "#{fetch(:ndenv_path)}/bin/ndenv exec" })
    SSHKit.config.command_map[:ndenv] = "#{fetch(:ndenv_path)}/bin/ndenv"

    fetch(:ndenv_map_bins).each do |command|
      SSHKit.config.command_map.prefix[command.to_sym].unshift(ndenv_prefix)
    end
  end
end

Capistrano::DSL.stages.each do |stage|
  after stage, 'ndenv:validate'
  after stage, 'ndenv:map_bins'
end

namespace :load do
  task :defaults do
    set :ndenv_path, -> {
      ndenv_path = fetch(:ndenv_custom_path)
      ndenv_path ||= if fetch(:ndenv_type, :user) == :system
        "/usr/local/ndenv"
      else
        "$HOME/.ndenv"
      end
    }

    set :ndenv_roles, fetch(:ndenv_roles, :all)

    set :ndenv_node_dir, -> { "#{fetch(:ndenv_path)}/versions/#{fetch(:ndenv_node)}" }
    set :ndenv_map_bins, %w{npm node}
  end
end
