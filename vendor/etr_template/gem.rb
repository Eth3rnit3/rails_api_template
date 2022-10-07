# frozen_string_literal: true

module EtrTemplate
  class Gem
    class << self
      def install(opt = {})
        init_global_gems(opt)
        init_development_gems(opt)
        init_test_gems(opt)
        init_development_and_test_gems(opt)

        run_bundle_install(opt)
      end

      private

      def run_bundle_install(opt)
        opt[:generator].run 'bundle install'
      end

      def init_global_gems(opt)
        opt[:generator].gem 'devise-jwt' if opt[:devisejwt]
        opt[:generator].gem 'pundit' if opt[:pundit]
        opt[:generator].gem 'rack-cors' if opt[:cors]
      end

      def init_development_gems(opt)
        opt[:generator].gem_group :development do
          opt[:generator].gem 'annotate' if opt[:annotate]
          opt[:generator].gem 'letter_opener' if opt[:letteropener]
          opt[:generator].gem 'rubocop-rails', require: false if opt[:rubocop]
        end
      end

      def init_test_gems(opt)
        opt[:generator].gem_group :test do
          opt[:generator].gem 'database_cleaner', require: false if opt[:databasecleaner]
          opt[:generator].gem 'simplecov', require: false
          opt[:generator].gem 'webmock'
        end
      end

      def init_development_and_test_gems(opt)
        opt[:generator].gem_group :development, :test do
          opt[:generator].gem 'byebug'
          opt[:generator].gem 'factory_bot_rails' if opt[:factorybot]
          opt[:generator].gem 'faker'
          opt[:generator].gem 'rspec-rails' if opt[:rspec]
        end
      end
    end
  end
end
