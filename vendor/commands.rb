def run_commands!
  run_devise_install!
  run_rspec_install!
end

def run_final_commands!
  run 'bundle exec rubocop . -A'
  git :init
  git add: "."
  git commit: "-a -m 'Initial commit'"
end

private

def run_devise_install!
  run 'rails generate devise:install'
end

def run_rspec_install!
  run 'rails generate rspec:install'
end