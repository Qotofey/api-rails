class User::ConfirmationService
  def initialize(user, current_user = nil)
    @user = user
    @current_user = current_user
  end

  def call
    @user.confirmed_by_user_id = @current_user&.id
    @user.confirmed_at = DateTime.now
    @user.save(validate: false)
  end
end
