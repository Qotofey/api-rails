class User::UpdateService
  def initialize(params, user, current_user = nil)
    @params = params
    @user = user
    @current_user = current_user
  end

  def call
    @user.assign_attributes(
      params,
      updated_by_user: @current_user
    )
    @user.save
  end
end
