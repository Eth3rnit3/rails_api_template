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

# Init
annotate          = ::EtrTemplate::Gems::Annotate.new(opt)
cors              = ::EtrTemplate::Gems::Cors.new(opt)
database_cleaner  = ::EtrTemplate::Gems::DatabaseCleaner.new(opt)
devise_jwt        = ::EtrTemplate::Gems::DeviseJwt.new(opt)
factory_bot       = ::EtrTemplate::Gems::FactoryBot.new(opt)
letter_opener     = ::EtrTemplate::Gems::LetterOpener.new(opt)
pundit            = ::EtrTemplate::Gems::Pundit.new(opt)
rspec             = ::EtrTemplate::Gems::RSpec.new(opt)
rubocop           = ::EtrTemplate::Gems::Rubocop.new(opt)

# Configure gems
devise_jwt.install
pundit.install
cors.install
annotate.install
letter_opener.install
factory_bot.install
rspec.install
database_cleaner.install
rubocop.install

# Dockerize
::EtrTemplate::Docker.install(opt)

# Run after install callbacks
devise_jwt.after_install
pundit.after_install
cors.after_install
annotate.after_install
letter_opener.after_install
factory_bot.after_install
rspec.after_install
database_cleaner.after_install
rubocop.after_install
