def run_commands!
  run_annotate_install!
  run_devise_install!
  run_pundit_install!
  run_active_storage_install!
  run_rspec_install!
end

def run_final_commands!
  run_rubocop_autocorrect!
  setup_jwt_secret!
  run_db_commands!
  run_git_commands!
end

private

def run_rubocop_autocorrect!
  run 'bundle exec rubocop . -A'
end

def run_db_commands!
  return if @dockerized

  rails_command 'db:drop'
  rails_command 'db:create'
  rails_command 'db:migrate'
  rails_command 'db:seed'
end

def run_git_commands!
  git :init
  inject_into_file '.gitignore' do
    "# Append by eth3rnit3 template\ncoverage\n"
  end
  git add: "."
  git commit: "-a -m 'Initial commit'"
end

def setup_jwt_secret!
  value = "jwt_secret: #{(0...64).map { ([65, 97].sample + rand(26)).chr }.push(rand(99)).join}"
  command = "EDITOR='echo \"#{value}\" >> ' rails credentials:edit"
  run command
end

def run_pundit_install!
  run 'rails g pundit:install'
end

def run_active_storage_install!
  run 'rails active_storage:install'
end

def run_annotate_install!
  run 'rails g annotate:install'
end

def run_devise_install!
  run 'rails generate devise:install'
end

def run_rspec_install!
  run 'rails generate rspec:install'
end