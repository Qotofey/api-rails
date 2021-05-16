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

  scope :by_confirmed_by_user_id, ->(user_id) { where(confirmed_by_user_id: user_id) }

  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :not_confirmed, -> { where(confirmed_at: nil) }
  scope :confirmed_after, ->(time) { where('confirmed_at >= ?', time) }
  scope :confirmed_before, ->(time) { where('confirmed_at < ?', time) }

  scope :live, -> { confirmed.not_deleted }
  scope :available, -> { all }

  def confirm
    self.confirmed_at = DateTime.now
    save(validate: false)
  end

  private

  def identifiers_preprocess
    self.login = login&.strip&.downcase
    self.email = email&.strip&.downcase
    self.phone = phone&.gsub(/\D/, '')
  end

  def names_preprocess
    self.first_name = first_name.strip.capitalize
    self.middle_name = middle_name&.strip&.capitalize
    self.last_name = last_name.strip.capitalize
  end
end
