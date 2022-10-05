require 'byebug'

# require dependencies
Dir["#{__dir__}/vendor/*.rb"].sort.each { |f| require f }

def source_paths
  [__dir__, "#{__dir__}/vendor", "#{__dir__}/templates", "#{__dir__}/docker"]
end

run_docker_commands!

# # Setup gems
# init_gems!

# # Setup initializers
# init_initializers!

# # Run dependencies installers
# run_commands!

# # Run dependencies generators
# run_generators!

# # Configure environments
# config_environments!

# # Copy files
# copy_files!

# # Add config to generated files
# update_initializers_config!

# # Final setup
# run_final_commands!

# run_docker_commands!
