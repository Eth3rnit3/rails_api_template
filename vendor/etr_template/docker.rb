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
        config_logger(opt)
      end

      private

      def dockerize(opt)
        opt[:generator].template '.env.erb', '.env'
        opt[:generator].template 'Dockerfile.erb', 'Dockerfile'
        opt[:generator].template 'docker-compose.yml.erb', 'docker-compose.yml'
        opt[:generator].copy_file 'docker-entrypoint.sh', 'docker-entrypoint.sh'
        opt[:generator].run 'chmod +x docker-entrypoint.sh'
        opt[:generator].copy_file 'Makefile', 'Makefile'
      end

      def configure_database(opt)
        return unless DB_ADAPTERS.include? opt[:database]

        opt[:generator].gsub_file 'config/database.yml', /username:\s\w*$/,
                                  "username: <%= ENV['DATABASE_USER'] %>"
        opt[:generator].gsub_file 'config/database.yml', /password:$/,
                                  "password: <%= ENV['DATABASE_PASSWORD'] %>"
        opt[:generator].gsub_file 'config/database.yml', /host:\s\w*$/,
                                  "host: <%= ENV['DATABASE_HOST'] %>"
        opt[:generator].gsub_file 'config/database.yml', /database:\s\w*$/,
                                  "database: <%= ENV['DATABASE_NAME'] %>"

        if opt[:database] == 'postgresql'
          opt[:generator].template 'init.sql.erb', 'init.sql'
          opt[:generator].gsub_file 'config/database.yml', /#username/, 'username'
          opt[:generator].gsub_file 'config/database.yml', /#password/, 'password'
          opt[:generator].gsub_file 'config/database.yml', /#host/, 'host'
        end
      end

      def config_logger(opt)
        opt[:generator].inject_into_file 'config/application.rb',
                                         after: 'class Application < Rails::Application' do
          "
            logger            = ActiveSupport::Logger.new($stdout)
            logger.formatter  = config.log_formatter
            config.logger     = ActiveSupport::TaggedLogging.new(logger)
          "
        end
      end
    end
  end
end
