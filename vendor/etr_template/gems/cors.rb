# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class Cors < Base
      class << self
        def install(_opt = {})
          config_environments
        end

        private

        def config_environments
          environment "
            config.middleware.insert_before 0, Rack::Cors do
              allow do
                origins '*'
                resource '*', headers: :any, methods: %i[get post put patch delete]
              end
            end
          ", env: 'development'
        end
      end
    end
  end
end
