# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class LetterOpener < Base
      class << self
        def install(_opt = {})
          config_environments
        end

        private

        def config_environments
          environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'
          environment 'config.action_mailer.delivery_method = :letter_opener', env: 'development'
          environment 'config.action_mailer.perform_deliveries = true', env: 'development'
        end
      end
    end
  end
end
