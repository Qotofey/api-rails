class User::SoftRestorationService
  def initialize(user)
    @user = user
  end

  def call
    @user.assign_attributes(
      deleted_at: nil,
      deleted_by_user_id: nil
    )
    @user.save(validate: false)
  end
end
