class User::EmailConfirmForm
  include ActiveModel::Model

  attr_accessor :id, :email, :code

  validates :email, presence: { message: 'blank' }, if: -> { id.blank? }
  validates :code, presence: { message: 'blank' }

  def submit
    return false unless valid?
    return false unless valid_registration?
    return false unless valid_confirmation_code?

    unconfirmed_user
  end

  private

  def users_by_id_or_email
    User.by_email(email.strip) || User.by_id(id)
  end

  def unconfirmed_users_by_email
    @unconfirmed_users_by_email ||= users_by_id_or_email.not_confirmed
  end

  def unconfirmed_user
    @registered_user ||= unconfirmed_users_by_email.take
  end

  def valid_registration?
    return true if unconfirmed_users_by_email.present?

    errors.add('confirmation_params', 'incorrect')
    false
  end

  # TODO: include redis
  def valid_confirmation_code?
    return true if code.eql? '11111'

    errors.add('confirmation_params', 'incorrect')
    false
  end
end
