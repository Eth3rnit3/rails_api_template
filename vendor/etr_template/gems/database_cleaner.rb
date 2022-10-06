# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class DatabaseCleaner < Base
      def install; end

      private

      def copy_files_from_template
        g.copy_file 'spec/support/database_cleaner.rb'
      end
    end
  end
end
