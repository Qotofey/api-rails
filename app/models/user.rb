class User < ApplicationRecord
  enum gender: {
    male: 0,
    female: 1
  }

  belongs_to :confirmed_by_user, class_name: 'User', optional: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :login, presence: true, uniqueness: { case_sensitive: false }

  before_save :identifiers_preprocess, :names_preprocess

  # scope :confirmed, -> { where.not(confirmed_at: nil) }
  # scope :not_confirmed, -> { where(confirmed_at: nil) }

  scope :live, -> { confirmed.not_deleted }

  def confirm
    self.confirmed_at = DateTime.now
    save(validate: false)
  end

  private

  def identifiers_preprocess
    self.login = login.strip.downcase
    self.email = email.strip.downcase
    self.phone = phone.gsub(/\s/, '').gsub(/(^+)8/, '7').gsub(/\D/, '')
  end

  def names_preprocess
    self.first_name = first_name.strip.capitalize
    self.middle_name = middle_name&.strip&.capitalize
    self.last_name = last_name.strip.capitalize
  end
end
