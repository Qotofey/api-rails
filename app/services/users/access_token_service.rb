class Users::AccessTokenService
  def initialize(token)
    @token = token
  end

  def call

  end

  private

  def decode
    JWT.decode(
      token,
      Rails.application.credentials.secret_key_base,
      true,
      { algorithm: 'HS256' }
    )
  end
end