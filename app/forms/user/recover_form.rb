class User::RecoverForm
  include ActiveModel::Model

  attr_accessor :id, :email, :code, :password, :password_confirmation

  validates :email, presence: { message: 'blank' }, if: -> { id.blank? }
  validates :code, presence: { message: 'blank' }
  validates :password, presence: { message: 'blank' }
  validates :password_confirmation, presence: { message: 'blank' }

  def submit
    return false unless valid?
    return false unless valid_password?
    return false unless valid_confirmation?
    return false unless valid_registration?
    return false unless valid_recovery_code?

    registered_user
  end

  private

  def users_by_id_or_email
    User.by_email(email.strip) || User.by_id(id)
  end

  def users_by_email
    @users_by_email ||= users_by_id_or_email.not_deleted
  end

  def registered_user
    @registered_user ||= users_by_email.take
  end

  def valid_password?
    return true if password == password_confirmation

    errors.add('password_confirmation', 'confirmation')
    false
  end

  def valid_registration?
    return true if users_by_email.present?

    errors.add('recovery_params', 'incorrect')
    false
  end

  def valid_confirmation?
    return true if registered_user.confirmed?

    errors.add('email', 'not_confirmed')
    false
  end

  # TODO: include redis
  def valid_recovery_code?
    return true if code.eql? '11111'

    errors.add('recovery_params', 'incorrect')
    false
  end
end
