# frozen_string_literal: true

require_relative 'helpers'

module EtrTemplate
  class Docker
    include Helpers

    class << self
      def install(opt = {})
        return unless opt[:docker]

        dockerize(opt)
        configure_database(opt)
      end

      private

      def dockerize(opt)
        opt[:generator].template '.env.erb', '.env'
        opt[:generator].template 'Dockerfile.erb', 'Dockerfile'
        opt[:generator].template 'docker-compose.yml.erb', 'docker-compose.yml'
        opt[:generator].copy_file 'docker-entrypoint.sh', 'docker-entrypoint.sh'
        opt[:generator].run 'chmod +x docker-entrypoint.sh'
      end

      def configure_database(opt)
        return unless DB_ADAPTERS.include? opt[:database]

        opt[:generator].copy_file 'config/database.yml', force: true
        opt[:generator].template 'init.sql.erb', 'init.sql'
      end
    end
  end
end
