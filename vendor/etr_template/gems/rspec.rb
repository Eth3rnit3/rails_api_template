# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class RSpec < Base
      class << self
        def install(opt = {})
          super(opt)
          copy_files_from_template
        end

        private

        def run_gem_install
          run 'rails generate rspec:install'
        end

        def copy_files_from_template
          copy_file 'spec/rails_helper.rb', force: true
        end
      end
    end
  end
end
