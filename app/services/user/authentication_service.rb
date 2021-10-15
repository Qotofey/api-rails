class User::AuthenticationService
  def initialize(email:, password:, current_user:)
    @email = email
    @password = password
    @current_user = current_user
  end

  def call; end

  private

  def base_auth

  end
end
