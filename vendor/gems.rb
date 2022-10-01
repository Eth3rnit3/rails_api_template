def init_gems!
  init_global_gems!
  init_development_gems!
  init_test_gems!
  init_development_and_test_gems!
end

private

def init_global_gems!
  gem 'devise-jwt'
  gem 'rack-cors'
end

def init_development_gems!
  gem_group :development do
    gem 'annotate'
    gem 'letter_opener'
    gem 'rubocop-rails', require: false
  end
end

def init_test_gems!
  gem_group :test do
    gem 'factory_bot_rails'
    gem 'rspec-rails'
    gem 'webmock'
    gem 'simplecov', require: false
  end
end

def init_development_and_test_gems!
  gem_group :development, :test do
    gem 'faker'
    gem 'byebug'
  end
end
