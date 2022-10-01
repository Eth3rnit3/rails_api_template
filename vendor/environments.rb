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
        origins 'http://localhost:4000'
        resource '*', headers: :any, methods: %i[get post put delete]
      end
    end
  ", env: 'development'
  environment 'config.action_mailer.delivery_method = :letter_opener'
  environment 'config.action_mailer.perform_deliveries = true'
end
