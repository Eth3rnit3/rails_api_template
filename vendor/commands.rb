def run_commands!
  run_annotate_install!
  run_devise_install!
  run_active_storage_install!
  run_rspec_install!
end

def run_final_commands!
  run 'bundle exec rubocop . -A'

  setup_jwt_secret!

  git :init
  git add: "."
  git commit: "-a -m 'Initial commit'"

  rails_command("db:drop")
  rails_command("db:create")
  rails_command("db:migrate")
  rails_command("db:seed")
end

private

def setup_jwt_secret!
  value = "jwt_secret: #{(0...64).map { ([65, 97].sample + rand(26)).chr }.push(rand(99)).join}"
  command = "EDITOR='echo \"#{value}\" >> ' rails credentials:edit"
  run command
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