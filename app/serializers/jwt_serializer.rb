class JwtSerializer
  def initialize(hash)
    @hash = hash
  end

  def as_json
    {
      access_token: @hash[:access_token],
      refresh_token: @hash[:refresh_token],
      expires_in: @hash[:expires_in]
    }
  end
end
