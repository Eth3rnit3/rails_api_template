# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class DeviseJwt < Base
      def install
        return unless install?

        super
        run_gem_generators
        copy_files_from_template
        add_jwt_config_to_devise
        init_sessions_store
        setup_jwt_secret
      end

      private

      def run_gem_install
        g.run 'rails generate devise:install'
      end

      def run_gem_generators
        g.generate :devise, 'User'
        g.generate :migration, 'AddJtiToUser', 'jti:string:index'
      end

      def copy_files_from_template
        g.copy_file 'spec/support/devise_helpers.rb'
      end

      def add_jwt_config_to_devise
        g.inject_into_file 'config/initializers/devise.rb', after: 'Devise.setup do |config|' do
          <<-RUBY
            config.jwt do |jwt|
              jwt.secret = Rails.application.credentials.jwt_secret
              jwt.dispatch_requests = [
                ['POST', %r{^/sign_in$}]
              ]
              jwt.revocation_requests = [
                ['DELETE', %r{^/sign_out$}]
              ]
              jwt.expiration_time = 15.day.to_i
            end
          RUBY
        end
      end

      def init_sessions_store
        g.initializer 'session_store.rb', <<-RUBY
            Rails.application.config.session_store :disabled
        RUBY
      end

      def setup_jwt_secret
        value = "jwt_secret: #{(0...64).map do
                                 ([65, 97].sample + rand(26)).chr
                               end.push(rand(99)).join}"
        command = "EDITOR='echo \"#{value}\" >> ' rails credentials:edit"
        g.run command
      end
    end
  end
end
