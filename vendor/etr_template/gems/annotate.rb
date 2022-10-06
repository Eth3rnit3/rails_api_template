# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class Annotate < Base
      class << self
        private

        def run_gem_install
          run 'rails g annotate:install'
        end
      end
    end
  end
end
