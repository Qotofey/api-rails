class User::TokenRefreshService
  def initialize(refresh_token)
    @refresh_token = refresh_token
  end

  def call; end
end
