class AuthByPhoneValidator
  attr_accessor :phone, :password

  include ActiveModel::Model

  validates :phone, phone: true, presence: true
  validates :password, presence: true
end
