class User::JwtCreationService
  SECRET = Rails.application.credentials.secret_key_base
  HASH_ALGORITHM = 'HS256'.freeze
  ACCESS_TOKEN_LIFETIME_IN_MINUTES = 30
  REFRESH_TOKEN_LIFETIME_IN_DAYS = 90

  def initialize(user, current_user = nil)
    @user = user
    @current_user = current_user
  end

  def call
    {
      access_token: build_access_token,
      expires_in: build_expires_in,
      refresh_token: build_refresh_token
    }
  end

  private

  def build_access_token
    @build_access_token ||= JWT.encode(access_token_payload, SECRET, HASH_ALGORITHM, header)
  end

  def build_refresh_token
    @build_refresh_token ||= ''
  end

  def access_token_expires_in
    @access_token_expires_in ||= token_init_at + ACCESS_TOKEN_LIFETIME_IN_MINUTES.minutes.to_i
  end

  def refresh_token_expires_in
    @refresh_token_expires_in ||= token_init_at + REFRESH_TOKEN_LIFETIME_IN_DAYS.days.to_i
  end
  #
  # def refresh_token
  #   nil
  # end
  #
  # def expires_in
  #   @user.expires_in
  # end

  def token_init_at
    @token_init_at ||= DateTime.now.to_i
  end

  def header
    { typ: 'JWT'.freeze, alg: HASH_ALGORITHM }
  end

  #
  # `exp` - service field, time of token expiration in Unix time format
  # `nbf` - service field, time of token expiration in Unix time format
  # `iat` - service field, time of token generation in Unix time format
  #
  def access_token_payload
    { exp: expires_in, nbf: init_at, iat: init_at, sub: @user.id,
      name: @user.full_name, roles: [] }
  end

  # TODO: include redis
  def refresh_token_payload
    { exp: refresh_token_expires_in, sub: @user.id }
  end

  # TODO: create refresh_tokens table in db
  # fields: refresh_token, fingerprint, ip, expires_in, os, user_id,
  #         browser, os
  #
  def key_refresh_token_cache
    @key_refresh_token_cache ||= SecureRandom.uuid
  end
end
