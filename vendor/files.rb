def copy_files!
  copy_config!
  copy_controllers!
  copy_models!
  copy_spec_config!
  copy_rubocop_config!
end

private

def copy_config!
  copy_file 'db/seeds.rb', force: true
  copy_file 'config/routes.rb', force: true
  copy_file 'config/initializers/devise.rb', force: true
end

def copy_controllers!
  copy_file 'app/controllers/application_controller.rb', force: true
  copy_file 'app/controllers/api/application_controller.rb'
end

def copy_models!
  copy_file 'app/models/user.rb', force: true
end

def copy_spec_config!
  copy_file 'spec/support/api_spec_helpers.rb'
  copy_file 'spec/support/database_cleaner.rb'
  copy_file 'spec/support/factory_bot.rb'
  copy_file 'spec/rails_helper.rb', force: true
end

def copy_rubocop_config!
  copy_file '.rubocop.yml'
end

