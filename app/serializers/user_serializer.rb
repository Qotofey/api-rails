class UserSerializer < ActiveModel::Serializer
  attributes %i[id login first_name last_name middle_name email phone birth_date gender
                confirmed_at deleted_at]

  has_one :created_by_user
  has_one :updated_by_user
  has_one :deleted_by_user
  has_one :confirmed_by_user
end
