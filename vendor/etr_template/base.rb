# frozen_string_literal: true

require_relative 'helpers'

module EtrTemplate
  class Base
    include Helpers

    class << self
      def configure(generator)
        install_docker = generator.ask 'Dockerize application? y/N'

        {
          generator: generator,
          docker: install_docker.match?(EtrTemplate::Helpers::CONFIRM_REGEX)
        }
      end

      def install(opt = {})
        generator = opt[:generator]
        run_active_storage_install(generator)
        config_environments(generator)
        copy_files_from_template(generator)
      end

      def after_install(opt = {})
        generator = opt[:generator]
        run_db_commands(generator) unless opt[:docker]
        run_git_commands(generator)
      end

      private

      def run_active_storage_install(generator)
        generator.run 'rails active_storage:install'
      end

      def config_environments(generator)
        generator.environment "routes.default_url_options[:host] = 'localhost:3000'", env: 'development'
      end

      def copy_files_from_template(generator)
        # Root
        generator.copy_file 'README_template.md', 'README.md', force: true
        # App
        generator.copy_file 'app/controllers/application_controller.rb', force: true
        generator.copy_file 'app/controllers/api/application_controller.rb'
        generator.copy_file 'app/models/user.rb', force: true
        # Db
        generator.copy_file 'db/seeds.rb', force: true
        # Config
        generator.copy_file 'config/routes.rb', force: true
        # Spec
        generator.copy_file 'spec/support/api_spec_helpers.rb'
      end

      def run_db_commands(generator)
        generator.rails_command 'db:drop'
        generator.rails_command 'db:create'
        generator.rails_command 'db:migrate'
        generator.rails_command 'db:seed'
      end

      def run_git_commands(generator)
        generator.git :init
        generator.inject_into_file '.gitignore' do
          "# Append by eth3rnit3 template\ncoverage\n"
        end
        generator.git add: '.'
        generator.git commit: "-a -m 'Initial commit'"
      end
    end
  end
end
