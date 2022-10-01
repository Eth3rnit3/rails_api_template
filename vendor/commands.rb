def run_commands!
  run_annotate_install!
  run_devise_install!
  run_active_storage_install!
  run_rspec_install!
end

def run_final_commands!
  run 'bundle exec rubocop . -A'
  git :init
  git add: "."
  git commit: "-a -m 'Initial commit'"

  jwt_secret = ask('Please enter a secret for JWT encryption')
  value = "jwt_secret: #{jwt_secret}"
  command = "EDITOR='echo \"#{value}\" >> ' rails credentials:edit"
  run command

  rails_command("db:drop")
  rails_command("db:create")
  rails_command("db:migrate")
  rails_command("db:seed")
end

private

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