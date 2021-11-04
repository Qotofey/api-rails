# Deprecated
#
# TODO: to delete
#
class AuthByEmailValidator
  attr_accessor :email, :password

  include ActiveModel::Model

  validates :email, email: true, presence: true
  validates :password, presence: true

  def call
    return false unless valid?
    return false unless valid_email?
    return false unless valid_password?

    user
  end

  private

  def users_by_email
    @users_by_email ||= User.by_email(email.strip)
  end

  def user
    @user ||= users_by_email.live.take
  end

  def valid_email?
    return false if users_by_email.count != 1
    return false if user.blank?

    true
  end

  def valid_password?
    user.sign_in(@password).present?
  end
end
