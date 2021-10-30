class User::JwtCreationService
  def initialize(user, current_user = nil)
    @user = user
    @current_user = current_user
  end

  def call
    {
      access_token: access_token,
      expires_in: expires_in,
      refresh_token: refresh_token
    }
  end

  private

  def access_token
    @user.access_token
  end

  def refresh_token
    nil
  end

  def expires_in
    @user.expires_in
  end
end
