class JwtSerializer
  def initialize(user)
    @user = user
  end

  def as_json
    {
      access_token: @user.access_token,
      expires_in: @user.expires_in,
      user: ::Users::IndexSerializer.new(@user).as_json
    }
  end
end
