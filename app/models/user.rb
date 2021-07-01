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
#  middle_name          :string(255)
#  password_digest      :string(255)
#  phone                :string(255)
#  promo                :string(255)
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
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_phone                 (phone) UNIQUE
#  index_users_on_promo                 (promo) UNIQUE
#  index_users_on_updated_by_user_id    (updated_by_user_id)
#
class User < ApplicationRecord
  include Deletable
  include Confirmable

  enum gender: {
    male: 0,
    female: 1
  }

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :middle_name, allow_blank: true, length: { maximum: 255 }
  validates :promo, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 16 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :phone, uniqueness: true, allow_blank: true, length: { is: 11 }

  before_save :identifiers_preprocess, :names_preprocess

  # scope :available, -> { UserPolicy::Scope.new(current_user, self) }
  scope :available, -> { all }

  scope :by_birth_date, ->(date) { where(birth_date: date) }
  scope :birth_date_after, ->(date) { where('birth_date > ?', date) }
  scope :birth_date_before, ->(date) { where('birth_date < ?', date) }
  scope :birth_date_from, ->(date) { where('birth_date >= ?', date) }
  scope :birth_date_to, ->(date) { where('birth_date <= ?', date) }

  scope :by_gender, ->(gender) { where(gender: gender) }

  scope :by_promo, lambda { |promo|
    where("LOWER(#{table_name}.promo) LIKE ?", "%#{promo.strip.downcase}%")
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
    where("LOWER(#{table_name}.middle_name) LIKE ?", "'%#{name.strip.downcase}%'")
  }
  scope :by_last_name, lambda { |name|
    where("LOWER(#{table_name}.last_name) LIKE ?", "%#{name.strip.downcase}%")
  }

  scope :live, -> { confirmed.not_deleted }

  def full_name
    @full_name ||= [first_name, middle_name, last_name].select(&:present?).join(' ')
  end

  def full_name_with_email
    @full_name_with_email ||= "#{full_name} (#{email})"
  end

  def format_phone
    @format_phone ||= "+#{phone}"
  end

  private

  def identifiers_preprocess
    self.promo = promo&.strip&.downcase
    self.email = email&.strip&.downcase
    self.phone = phone&.gsub(/\D/, '')
  end

  def names_preprocess
    self.first_name = first_name.strip.capitalize
    self.middle_name = middle_name&.strip&.capitalize
    self.last_name = last_name.strip.capitalize
  end
end
