def init_initializers!
  init_sessions_store!
end

def update_initializers_config!
  add_jwt_config_to_devise!
end

private

def add_jwt_config_to_devise!
  inject_into_file 'config/initializers/devise.rb', after: 'Devise.setup do |config|' do
    "\n  config.jwt do |jwt|\n    jwt.secret = Rails.application.credentials.jwt_secret!\n  end"
  end
end

def init_sessions_store!
  initializer 'session_store.rb', <<-CODE
    Rails.application.config.session_store :disabled
  CODE
end