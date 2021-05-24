FactoryBot.define do
  factory :user, aliases: %i[created_by_user updated_by_user deleted_by_user confirmed_by_user] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    middle_name { Faker::Name.middle_name }
    login { Faker::Internet.unique.username(separators: %w[]) }
    email { Faker::Internet.unique.safe_email }
    phone { nil }
    password_digest { 'Password123Z' }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    gender { Faker::Gender.binary_type.downcase }
    confirmed_at { Date.current }
    deleted_at { nil }
    created_by_user { nil }
    updated_by_user { nil }
    deleted_by_user { nil }
    confirmed_by_user { nil }

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
