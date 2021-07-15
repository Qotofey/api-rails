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
#  gender               :string(255)
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
FactoryBot.define do
  factory :user, class: 'User',
                 aliases: %i[created_by_user updated_by_user deleted_by_user confirmed_by_user] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    middle_name { Faker::Name.middle_name }
    promo { Faker::Internet.unique.username(separators: %w[]) }
    email { Faker::Internet.unique.safe_email }
    phone { nil }
    password { 'Password123Z' }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    gender { Faker::Gender.binary_type.downcase }
    confirmed_at { Date.current }
    deleted_at { nil }
    created_by_user { nil }
    updated_by_user { nil }
    deleted_by_user { nil }
    confirmed_by_user { nil }

    trait :with_phone do
      phone { Faker::Base.unique.numerify('791########') }
    end

    trait :deleted do
      deleted_at { Date.current }
      deleted_by_user
    end

    trait :confirmed do
      confirmed_at { Date.current }
      confirmed_by_user
    end

    trait :undeleted do
      deleted_at { nil }
      deleted_by_user { nil }
    end

    trait :unconfirmed do
      confirmed_at { nil }
      confirmed_by_user { nil }
    end
  end
end
