def run_docker_commands!
  install_docker = ask('Dockerize application?')
  dockerize! if install_docker.match?(/y|Y|o|O|yes|Yes|YES|oui|Oui|OUI/)
end

private

def dockerize!
  template '.env.erb', '.env'
  template 'Dockerfile.erb', 'Dockerfile'
  template 'docker-compose.yml.erb', 'docker-compose.yml'
  copy_file 'dockerscripts/api-entrypoint.sh', 'dockerscripts/api-entrypoint.sh'
end