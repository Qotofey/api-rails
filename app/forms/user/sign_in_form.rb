class User::SignInForm
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, presence: { message: 'blank' }
  validates :password, presence: { message: 'blank' }

  def submit
    return false unless valid?
    return false unless valid_registration?
    return false unless valid_confirmation?
    return false unless valid_authentication?

    registered_user
  end

  private

  def users_by_email
    @users_by_email ||= User.by_email(email.strip).not_deleted
  end

  def registered_user
    @registered_user ||= users_by_email.take
  end

  def valid_registration?
    return true if users_by_email.present?

    errors.add('authentication_params', 'incorrect')
    false
  end

  def valid_confirmation?
    return true if registered_user.confirmed?

    errors.add('email', 'not_confirmed')
    false
  end

  def valid_authentication?
    return true if registered_user.sign_in(password).present?

    errors.add('authentication_params', 'incorrect')
    false
  end
end
