def init_initializers!
  init_sessions_store!
end

private

def init_sessions_store!
  initializer 'session_store.rb', <<-CODE
    Rails.application.config.session_store :disabled
  CODE
end