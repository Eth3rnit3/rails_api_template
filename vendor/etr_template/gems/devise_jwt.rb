# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class DeviseJwt < Base
      class << self
        def install(opt = {})
          super(opt)
          run_gem_generators
          copy_files_from_template
          add_jwt_config_to_devise
          init_sessions_store
        end

        def after_install(opt = {})
          super(opt)
          setup_jwt_secret
        end

        private

        def run_gem_intall
          run 'rails generate devise:install'
        end

        def run_gem_generators
          generate :devise, 'User'
          generate :migration, 'AddJtiToUser', 'jti:string:index'
        end

        def copy_files_from_template
          copy_file 'spec/support/devise_helpers.rb'
        end

        def add_jwt_config_to_devise
          inject_into_file 'config/initializers/devise.rb', after: 'Devise.setup do |config|' do
            "\n  config.jwt do |jwt|\n    jwt.secret = Rails.application.credentials.jwt_secret!\n  end"
          end
        end

        def init_sessions_store
          initializer 'session_store.rb', <<-CODE
            Rails.application.config.session_store :disabled
          CODE
        end

        def setup_jwt_secret
          value = "jwt_secret: #{(0...64).map { ([65, 97].sample + rand(26)).chr }.push(rand(99)).join}"
          command = "EDITOR='echo \"#{value}\" >> ' rails credentials:edit"
          run command
        end
      end
    end
  end
end
