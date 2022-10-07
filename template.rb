def source_paths
  [__dir__, "#{__dir__}/vendor", "#{__dir__}/templates", "#{__dir__}/docker"]
end

# require dependencies
Dir["#{__dir__}/vendor/**/*.rb"].sort.each { |f| require f }

# Configurable gems
def configurable_gems
  @configurable_gems ||= %w[
    Annotate
    Cors
    DatabaseCleaner
    DeviseJwt
    FactoryBot
    LetterOpener
    Pundit
    RSpec
    Rubocop
  ]
end

# Setup options
opt = ::EtrTemplate::Base.configure(self, configurable_gems)
                         .merge(sym_options)

# Install and configure template data
::EtrTemplate::Base.install(opt)

# Install gems
::EtrTemplate::Gem.install(opt)

# Init
configurable_gems.map! { |conf_g| "::EtrTemplate::Gems::#{conf_g}".constantize.new(opt) }

# Configure gems
configurable_gems.each(&:install)

# Dockerize
::EtrTemplate::Docker.install(opt)

# # After install and configure template data
::EtrTemplate::Base.after_install(opt)

# # Run after install callbacks
configurable_gems.each(&:after_install)
