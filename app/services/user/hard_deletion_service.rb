class User::HardDeletionService
  def initialize(user)
    @user = user
  end

  def call
    @user.destroy
  end
end