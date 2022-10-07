# frozen_string_literal: true

module EtrTemplate
  module Gems
    class Base
      attr_reader :opt, :g, :gem_key

      def initialize(opt = {})
        @opt    = opt
        @g      = opt[:generator]
        @gem_key = self.class.name.demodulize.downcase.to_sym
      end

      def install
        return unless install?

        run_gem_install
      end

      def after_install; end

      def install?
        opt[gem_key]
      end

      private

      def run_gem_install
        raise NotImplementedError
      end
    end
  end
end
