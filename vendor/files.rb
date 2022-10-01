def copy_files!
  copy_models!
  copy_spec_config!
  copy_rubocop_config!
end

private

def copy_models!
  copy_file 'app/models/user.rb'
end

def copy_spec_config!
  copy_file 'spec/support/api_spec_helpers.rb'
  copy_file 'spec/support/database_cleaner.rb'
  copy_file 'spec/support/factory_bot.rb'
  copy_file 'spec/rails_helper.rb'
end

def copy_rubocop_config!
  copy_file '.rubocop.yml'
end

