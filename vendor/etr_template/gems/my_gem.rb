# frozen_string_literal: true

require_relative 'base'

module EtrTemplate
  module Gems
    class MyGem < Base
      class << self
        def install(opt = {})
          super(opt)
        end

        def after_install(opt = {}); end

        private

        def run_gem_intall; end
      end
    end
  end
end
