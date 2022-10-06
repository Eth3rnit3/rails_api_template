# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class Pundit < Base
      class << self
        private

        def run_gem_install
          run 'rails g pundit:install'
        end
      end
    end
  end
end
