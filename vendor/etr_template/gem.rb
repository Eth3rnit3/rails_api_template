# frozen_string_literal: true

module EtrTemplate
  class Gem
    class << self
      def install(generator)
        init_global_gems(generator)
        init_development_gems(generator)
        init_test_gems(generator)
        init_development_and_test_gems(generator)

        run_bundle_install(generator)
      end

      private

      def run_bundle_install(generator)
        generator.run 'bundle install'
      end

      def init_global_gems(generator)
        generator.gem 'devise-jwt'
        generator.gem 'pundit'
        generator.gem 'rack-cors'
      end

      def init_development_gems(generator)
        gem_group :development do
          generator.gem 'annotate'
          generator.gem 'letter_opener'
          generator.gem 'rubocop-rails', require: false
        end
      end

      def init_test_gems(generator)
        gem_group :test do
          generator.gem 'database_cleaner', require: false
          generator.gem 'simplecov', require: false
          generator.gem 'webmock'
        end
      end

      def init_development_and_test_gems(generator)
        gem_group :development, :test do
          generator.gem 'byebug'
          generator.gem 'factory_bot_rails'
          generator.gem 'faker'
          generator.gem 'rspec-rails'
        end
      end
    end
  end
end
