# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class Rubocop < Base
      def install
        super
        copy_files_from_template
      end

      def after_install
        super
        run_rubocop_autocorrect
      end

      private

      def run_rubocop_autocorrect
        g.run 'bundle exec rubocop . -A'
      end

      def copy_files_from_template
        g.copy_file '.rubocop.yml'
      end
    end
  end
end
