# frozen_string_literal: true

module EtrTemplate
  RAILS_DB_ADAPTERS = %w[postgresql sqlite3 mysql oracle sqlserver jdbcmysql jdbcsqlite3 jdbcpostgresql jdbc].freeze
  DB_ADAPTERS = %w[postgresql sqlite sqlite3].freeze

  module Helpers
    CONFIRM_REGEX = /y|Y|o|O|yes|Yes|YES|oui|Oui|OUI/
  end
end

EtrTemplate::RAILS_DB_ADAPTERS.each do |adapter|
  define_method "#{adapter}?" do
    options[:database] == adapter
  end
end

def options
  @opt ||= options.transform_keys!(&:to_sym)
end

def db_compatible?
  EtrTemplate::DB_ADAPTERS.include? options[:database]
end

def render_partial(file_name, context)
  file_path = source_paths
              .map { |source_path| "#{source_path}/#{file_name}" }
              .find { |path| File.exist? path }
  raise "#{file_name} not found! search in #{source_paths}" if file_path.nil?

  ERB.new(File.read(file_path)).result(context)
end
