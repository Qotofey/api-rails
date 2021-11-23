class User::SoftDeletionService
  def initialize(user, current_user = nil)
    @user = user
    @current_user = current_user
  end

  def call
    @user.update_columns(
      deleted_at: DateTime.now,
      deleted_by_user_id: @current_user&.id
    )
  end
end
