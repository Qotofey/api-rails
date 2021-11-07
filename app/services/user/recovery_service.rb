class User::RecoveryService
  def initialize(user, password)
    @user = user
    @password = password
  end

  def call
    @user.update(password: @password)
  end
end
