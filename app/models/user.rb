# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  birth_date           :date
#  confirmed_at         :datetime
#  deleted_at           :datetime
#  email                :string(255)
#  first_name           :string(255)
#  gender               :integer
#  last_name            :string(255)
#  login                :string(255)
#  middle_name          :string(255)
#  password_digest      :string(255)
#  phone                :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  confirmed_by_user_id :bigint
#  created_by_user_id   :bigint
#  deleted_by_user_id   :bigint
#  updated_by_user_id   :bigint
#
# Indexes
#
#  index_users_on_confirmed_by_user_id  (confirmed_by_user_id)
#  index_users_on_created_by_user_id    (created_by_user_id)
#  index_users_on_deleted_by_user_id    (deleted_by_user_id)
#  index_users_on_updated_by_user_id    (updated_by_user_id)
#
class User < ApplicationRecord
  attr_accessor :confirmed, :deleted

  enum gender: {
    male: 0,
    female: 1
  }

  belongs_to :confirmed_by_user, class_name: 'User', optional: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :login, presence: true, uniqueness: { case_sensitive: false }

  before_save :identifiers_preprocess, :names_preprocess, :check_confirmation, :check_deletion

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
    where("#{table_name}.phone LIKE ?", "%#{phone.gsub(/\s/, '').sub(/(^+)8/, '7').gsub(/\D/, '')}%")
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

  def unconfirm
    self.confirmed_at = nil
    save(validate: false)
  end

  def full_name
    @full_name ||= [first_name, middle_name, last_name].join(' ').gsub(/\s{2,}/, ' ').strip
  end

  def full_name_with_email
    @full_name_with_email ||= "#{full_name} (#{email})"
  end

  def format_phone
    @format_phone ||= "+#{phone}"
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

  def check_confirmation
    return unless @confirmed.in? [false, true]

    self.confirmed_by_user_id = @confirmed ? current_user_id : nil
    self.confirmed_at = @confirmed ? DateTime.now : nil
  end

  def check_deletion
    return unless @deleted.in? [false, true]

    self.deleted_by_user_id = @deleted ? current_user_id : nil
    self.deleted_at = @deleted ? DateTime.now : nil
  end
end
