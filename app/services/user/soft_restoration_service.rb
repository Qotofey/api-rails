class User::SoftRestorationService
  def initialize(user)
    @user = user
  end

  def call
    @user.soft_restore
  end
end
