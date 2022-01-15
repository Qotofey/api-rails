# frozen_string_literal: true

module Authenticatable
  extend ActiveSupport::Concern

  included do
    const_set(:HMAC_SECRET, Rails.application.credentials.secret_key_base)
    const_set(:HASH_ALGORITHM, 'HS256')
    const_set(:ACCESS_TOKEN_LIFETIME_IN_MINUTES, 240)
    const_set(:REFRESH_TOKEN_LIFETIME_IN_DAYS, 90)

    has_secure_password
  end

  def sign_in(password)
    # @access_token = nil
    # @expires_in = nil

    authenticate(password)
  end
end
