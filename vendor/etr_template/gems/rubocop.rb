# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class Rubocop < Base
      class << self
        def install(opt = {})
          super(opt)
          copy_files_from_template
        end

        def after_install(opt = {})
          super(opt)
          run_rubocop_autocorrect
        end

        private

        def run_rubocop_autocorrect
          run 'bundle exec rubocop . -A'
        end

        def copy_files_from_template
          copy_file '.rubocop.yml'
        end
      end
    end
  end
end
