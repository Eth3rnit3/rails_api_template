require 'byebug'
# require dependencies
Dir["#{__dir__}/vendor/*.rb"].sort.each { |f| require f }

def source_paths
  [__dir__, "#{__dir__}/vendor", "#{__dir__}/templates"]
end

# Setup Gems
init_gems!

# Setup Initializers
init_initializers!

# Copy files
copy_files!

# Config Environment
# environment 'config.action_mailer.default_url_options = {host: "http://yourwebsite.example.com"}', env: 'production'
