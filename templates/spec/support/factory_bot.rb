# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.factory_bot.definition_file_paths = ['spec/factories']
  config.generators do |g|
    g.factory_bot dir: 'spec/factories'
    g.test_framework :rspec, fixture: true
    g.fixture_replacement :factory_bot
  end
end