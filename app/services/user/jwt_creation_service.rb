class User::JwtCreationService
  def initialize(user, current_user = nil)
    @user = user
    @current_user = current_user
  end

  def call
    {
      access_token: build_access_token,
      expires_in: access_token_expires_in,
      refresh_token: build_refresh_token
    }
  end

  private

  def build_access_token
    @build_access_token ||= JWT.encode(payload, @user.class::HMAC_SECRET, @user.class::HASH_ALGORITHM, header)
  end

  # TODO: include redis
  # TODO: create refresh_tokens table in db
  # fields: refresh_token, fingerprint, ip, expires_in, os, user_id,
  #         browser, os
  #
  def build_refresh_token
    @build_refresh_token ||= SecureRandom.uuid
  end

  def access_token_expires_in
    @access_token_expires_in ||= token_init_at + @user.class::ACCESS_TOKEN_LIFETIME_IN_MINUTES.minutes.to_i
  end

  def refresh_token_expires_in
    @refresh_token_expires_in ||= token_init_at + @user.class::REFRESH_TOKEN_LIFETIME_IN_DAYS.days.to_i
  end

  def token_init_at
    @token_init_at ||= DateTime.now.to_i
  end

  def header
    { typ: 'JWT'.freeze, alg: @user.class::HASH_ALGORITHM }
  end

  # `exp` (Expiration Time) - service field, time of token expiration in Unix time format
  # `nbf` (Not Before) - service field, time of token begin in Unix time format
  # `iat` (Issued At) - service field, time of token generation in Unix time format
  # `sub` (Subject)
  # `aud` (Audience)
  # `iss` (Issuer)
  # `jti` (JWT ID)
  def payload
    { exp: access_token_expires_in, nbf: token_init_at, iat: token_init_at, sub: @user.id,
      name: @user.full_name, roles: [] }
  end
end
