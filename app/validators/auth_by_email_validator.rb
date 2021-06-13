class AuthByEmailValidator
  attr_accessor :email, :password
  include ActiveModel::Model

  validates :email, email: true, presence: true
  validates :password, presence: true

  def apply
    return false unless valid?

    true
  end

  private

  def user; end

  def valid_email?; end
end