require 'byebug'
# byebug
def source_paths
  [__dir__, "#{__dir__}/vendor", "#{__dir__}/templates", "#{__dir__}/docker"]
end

# require dependencies
Dir["#{__dir__}/vendor/**/*.rb"].sort.each { |f| require f }

# Setup options
opt = ::EtrTemplate::Base.configure(self).merge(options.transform_keys(&:to_sym))

# Install and configure template data
::EtrTemplate::Base.install(opt)

# Install gems
::EtrTemplate::Gem.install(opt)

# Cconfigure gems
::EtrTemplate::Gems::Annotate.install(opt)
::EtrTemplate::Gems::Cors.install(opt)
::EtrTemplate::Gems::DatabaseCleaner.install(opt)
::EtrTemplate::Gems::DeviseJwt.install(opt)
::EtrTemplate::Gems::FactoryBot.install(opt)
::EtrTemplate::Gems::LetterOpener.install(opt)
::EtrTemplate::Gems::Pundit.install(opt)
::EtrTemplate::Gems::RSpec.install(opt)
::EtrTemplate::Gems::Rubocop.install(opt)

# Dockerize
::EtrTemplate::Docker.install(opt)

# Run after install callbacks
::EtrTemplate::Base.after_install(opt)
::EtrTemplate::Gems::Annotate.after_install(opt)
::EtrTemplate::Gems::Cors.after_install(opt)
::EtrTemplate::Gems::DatabaseCleaner.after_install(opt)
::EtrTemplate::Gems::DeviseJwt.after_install(opt)
::EtrTemplate::Gems::FactoryBot.after_install(opt)
::EtrTemplate::Gems::LetterOpener.after_install(opt)
::EtrTemplate::Gems::Pundit.after_install(opt)
::EtrTemplate::Gems::RSpec.after_install(opt)
::EtrTemplate::Gems::Rubocop.after_install(opt)
