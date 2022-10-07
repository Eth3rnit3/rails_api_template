# frozen_string_literal: true

module ApiSpecHelpers
  def json
    JSON.parse(response.body, symbolize_names: true)
  end
end
