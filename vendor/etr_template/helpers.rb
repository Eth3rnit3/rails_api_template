# frozen_string_literal: true

module EtrTemplate
  DB_ADAPTERS = %w[postgresql sqlite sqlite3].freeze

  module Helpers
    CONFIRM_REGEX = /y|Y|o|O|yes|Yes|YES|oui|Oui|OUI/

    def postgresql?
      options['database'] == 'postgresql'
    end
  end
end
