# frozen_string_literal: true

class User < ApplicationRecord
  require 'devise/jwt/test_helpers'

  devise  :database_authenticatable,
          :jwt_authenticatable,
          :registerable,
          jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  def jwt
    token, _payload = Warden::JWTAuth::UserEncoder.new.call(self, :user, Warden::JWTAuth.config.aud_header)
    token
  end
end
