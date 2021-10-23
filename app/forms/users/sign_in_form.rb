class Users::SignInForm
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, email: true, presence: true
  validates :password, presence: true

  def call
    return false unless valid?

    true
  end

  private

  def users_by_email

  end
end