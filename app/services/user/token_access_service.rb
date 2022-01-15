# frozen_string_literal: true

class User::TokenAccessService
  def initialize(access_token, klass = User)
    @access_token = access_token
    @klass = klass
  end

  def call
    decode_token.present? && payload.present? && expired? && started? && created? && user_id
  end

  def decode_token
    @decode_token ||= JWT.decode(@access_token, @klass::HMAC_SECRET, true, algorithm: @klass::HASH_ALGORITHM)
  rescue JWT::VerificationError
    false
  rescue JWT::ExpiredSignature
    false
  rescue JWT::DecodeError
    false
  end

  def payload
    @payload ||= decode_token[0]
  end

  def header
    @header ||= decode_token[1]
  end

  def user_id
    payload['sub'].to_i
  end

  def expired?
    payload['exp'].to_i > DateTime.now.to_i
  end

  def started?
    payload['nbf'].to_i <= DateTime.now.to_i
  end

  def created?
    payload['iat'].to_i <= DateTime.now.to_i
  end
end
