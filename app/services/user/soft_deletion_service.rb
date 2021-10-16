class User::SoftDeletionService
  def initialize(user)
    @user = user
  end

  def call
    @user.soft_destroy
  end
end
