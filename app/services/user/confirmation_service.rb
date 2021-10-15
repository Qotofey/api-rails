class User::ConfirmationService
  def initialize(user)
    @user = user
  end

  def call
    @user.confirm
  end
end
