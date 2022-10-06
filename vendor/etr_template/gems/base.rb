# frozen_string_literal: true

module EtrTemplate
  module Gems
    class Base
      class << self
        def install(_opt = {})
          run_gem_install
        end

        def after_install(opt = {}); end

        def g(opt)
          opt[:generator]
        end

        private

        def run_gem_install
          raise NotImplementedError
        end
      end
    end
  end
end
