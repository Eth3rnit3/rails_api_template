# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class Pundit < Base
      private

      def run_gem_install
        g.run 'rails g pundit:install'
      end
    end
  end
end
