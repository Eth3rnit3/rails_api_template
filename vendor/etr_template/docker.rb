# frozen_string_literal: true

require_relative 'helpers'

module EtrTemplate
  class Docker
    include Helpers

    class << self
      def install(opt = {})
        return unless opt[:docker]

        dockerize(opt)
        configure_databases(opt)
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

      def configure_databases(opt)
        return unless DB_ADAPTERS.include? opt[:database]

        config_database_with_environment(opt[:generator].destination_root)
        config_postgres(opt) if opt[:database] == 'postgresql'
      end

      def config_database_with_environment(root_path)
        config_path = "#{root_path}/config/database.yml"
        config = YAML.load_file config_path
        default = config.delete('default')

        config.each_key do |env|
          config[env]['adapter']  = default['adapter']
          config[env]['encoding'] = default['encoding']
          config[env]['pool']     = default['pool']
          config[env]['host']     = "<%= ENV['DATABASE_HOST'] %>"
          config[env]['database'] = "<%= ENV['DATABASE_NAME'] %>_#{env}"
          config[env]['username'] = "<%= ENV['DATABASE_USER'] %>"
          config[env]['password'] = "<%= ENV['DATABASE_PASSWORD'] %>"
        end

        File.write(config_path, config.to_yaml)
      end

      def config_postgres(opt)
        opt[:generator].template 'init.sql.erb', 'init.sql'
        opt[:generator].gsub_file 'config/database.yml', /#username/, 'username'
        opt[:generator].gsub_file 'config/database.yml', /#password/, 'password'
        opt[:generator].gsub_file 'config/database.yml', /#host/, 'host'
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
