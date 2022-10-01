class User < ApplicationRecord
  require 'devise/jwt/test_helpers'

  devise  :database_authenticatable,
          :jwt_authenticatable,
          jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  def jwt
    Devise::JWT::TestHelpers.auth_headers({}, self)['Authorization']
  end
end
