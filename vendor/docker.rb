def run_docker_commands!
  install_docker = ask 'Dockerize application? y/N'
  dockerize! if install_docker.match? Eth3rnit3Template::Helper::CONFIRM_REGEX
end

private

def dockerize!
  @dockerized = true
  template '.env.erb', '.env'
  template 'Dockerfile.erb', 'Dockerfile'
  template 'docker-compose.yml.erb', 'docker-compose.yml'
  copy_file 'docker-entrypoint.sh', 'docker-entrypoint.sh'
  run "chmod +x docker-entrypoint.sh"

  configure_database!
end

def configure_database!
  return unless db_compatible?

  copy_file 'config/database.yml', force: true
  template 'init.sql.erb', 'init.sql'
end