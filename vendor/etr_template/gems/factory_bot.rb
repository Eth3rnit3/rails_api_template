# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class FactoryBot < Base
      def install
        config_environments
      end

      private

      def config_environments
        g.environment "config.factory_bot.definition_file_paths = ['spec/factories']", env: 'development'
        g.environment "config.factory_bot.definition_file_paths = ['spec/factories']", env: 'test'
      end

      def copy_files_from_template
        g.copy_file 'spec/support/factory_bot.rb'
      end
    end
  end
end
