module Docker
  DB_ADAPTERS = %w[postgresql sqlite sqlite3].freeze
end

def run_docker_commands!
  install_docker = ask 'Dockerize application? y/N'
  dockerize! if install_docker.match? /y|Y|o|O|yes|Yes|YES|oui|Oui|OUI/
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
  return unless Docker::DB_ADAPTERS.include? options['database']

  copy_file 'config/database.yml', force: true
  template 'init.sql.erb', 'init.sql'
end