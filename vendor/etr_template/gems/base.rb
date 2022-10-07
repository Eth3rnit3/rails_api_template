# frozen_string_literal: true

module EtrTemplate
  module Gems
    class Base
      attr_reader :g

      def initialize(opt = {})
        @g = opt[:generator]
      end

      def install
        run_gem_install
      end

      def after_install; end

      private

      def run_gem_install
        raise NotImplementedError
      end
    end
  end
end
