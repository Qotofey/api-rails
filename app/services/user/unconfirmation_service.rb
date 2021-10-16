class User::UnconfirmationService
  def initialize(user)
    @user = user
  end

  def call
    @user.unconfirm
  end
end
