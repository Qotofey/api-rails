module Authenticatable
  extend ActiveSupport::Concern

  included do
    const_set(:HMAC_SECRET, Rails.application.credentials.secret_key_base)
    const_set(:ACCESS_HASH, 'HS256'.freeze)

    has_secure_password
  end

  def sign_in(password)
    @access_token = nil
    @expires_in = nil

    authenticate(password)
  end

  def access_token
    @access_token ||= JWT.encode(
      payload,
      self.class.const_get(:HMAC_SECRET),
      self.class.const_get(:ACCESS_HASH),
      header
    )
  end

  def expires_in
    @expires_in ||= init_at + 30.minutes.to_i
  end

  private

  def header
    {
      typ: 'JWT'
    }
  end

  def payload
    {
      user_id: id,
      exp: expires_in,
      nbf: init_at,
      iat: init_at
    }
  end

  def init_at
    @init_at ||= DateTime.now.to_i
  end
end
