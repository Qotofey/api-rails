class User::CreationService
  def initialize(params, current_user = nil)
    @params = params
    @current_user = current_user
  end

  def call
    User.create(@params)
  end
end
