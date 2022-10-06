# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class DatabaseCleaner < Base
      class << self
        def install(opt = {}); end

        private

        def copy_files_from_template
          copy_file 'spec/support/database_cleaner.rb'
        end
      end
    end
  end
end
