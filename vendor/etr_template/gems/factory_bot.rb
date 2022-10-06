# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class FactoryBot < Base
      class << self
        def install(_opt = {})
          config_environments
        end

        private

        def config_environments
          environment "config.factory_bot.definition_file_paths = ['spec/factories']", env: 'development'
          environment "config.factory_bot.definition_file_paths = ['spec/factories']", env: 'test'
        end

        def copy_files_from_template
          copy_file 'spec/support/factory_bot.rb'
        end
      end
    end
  end
end
