# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class Annotate < Base
      private

      def run_gem_install
        g.run 'rails g annotate:install'
      end
    end
  end
end
