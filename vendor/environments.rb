def config_environments!
  config_development!
end

private

def config_development!
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'
  environment "routes.default_url_options[:host] = 'localhost:3000'", env: 'development'
  environment "
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post put patch delete]
      end
    end
  ", env: 'development'
  environment 'config.action_mailer.delivery_method = :letter_opener', env: 'development'
  environment 'config.action_mailer.perform_deliveries = true', env: 'development'
  environment "config.factory_bot.definition_file_paths = ['spec/factories']", env: 'development'
  environment "config.factory_bot.definition_file_paths = ['spec/factories']", env: 'test'
end
