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
  scope :confirmed_after, ->(time) { where('confirmed_at > ?', time) }
  scope :confirmed_before, ->(time) { where('confirmed_at < ?', time) }
  scope :confirmed_from, ->(time) { where('confirmed_at >= ?', time) }
  scope :confirmed_to, ->(time) { where('confirmed_at <= ?', time) }

  scope :by_birth_date, ->(date) { where(birth_date: date) }
  scope :birth_date_after, ->(date) { where('birth_date > ?', date) }
  scope :birth_date_before, ->(date) { where('birth_date < ?', date) }
  scope :birth_date_from, ->(date) { where('birth_date >= ?', date) }
  scope :birth_date_to, ->(date) { where('birth_date <= ?', date) }

  scope :by_login, lambda { |login|
    where("LOWER(#{table_name}.login) LIKE ?", "%#{login.strip.downcase}%")
  }
  scope :by_phone, lambda { |phone|
    where("#{table_name}.phone LIKE ?", "%#{phone.gsub(/\s/, '').gsub(/(^+)8/, '7').gsub(/\D/, '')}%")
  }
  scope :by_email, lambda { |email|
    where("LOWER(#{table_name}.email) LIKE ?", "%#{email.strip.downcase}%")
  }
  scope :by_first_name, lambda { |name|
    where("LOWER(#{table_name}.first_name) LIKE ?", "%#{name.strip.downcase}%")
  }
  scope :by_middle_name, lambda { |name|
    where("LOWER(#{table_name}.middle_name) LIKE ?", "%#{name.strip.downcase}%")
  }
  scope :by_last_name, lambda { |name|
    where("LOWER(#{table_name}.last_name) LIKE ?", "%#{name.strip.downcase}%")
  }

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
