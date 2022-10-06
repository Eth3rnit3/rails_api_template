# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class MyGem < Base
      def install; end

      def after_install; end

      private

      def run_gem_intall; end
    end
  end
end
