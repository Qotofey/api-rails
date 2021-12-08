class User::IdEmailForm
  include ActiveModel::Model

  attr_accessor :id, :email

  validates :email, presence: { message: 'blank' }, if: -> { id.blank? }

  def submit; end
end
