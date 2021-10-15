class User::CreationService
  def initialize(params)
    @params = params
  end

  def call
    create_user
  end

  private

  def create_user
    User.create(@params)
  end
end