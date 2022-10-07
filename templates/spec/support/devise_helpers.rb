# frozen_string_literal: true

module DeviseHelpers
  def sign_in(user)
    request.headers.merge!({ Authorization: user.jwt })
  end
end
