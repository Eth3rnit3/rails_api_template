def run_generators!
  run_devise_generator!
end

private

def run_devise_generator!
  generate(:devise, 'User')
  generate(:migration, 'AddJtiToUser', 'jti:string:index')
end