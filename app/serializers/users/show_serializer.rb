class Users::ShowSerializer < ::Users::IndexSerializer
  attributes(%i[id login first_name middle_name last_name phone email birth_date gender])

  has_one :created_by_user, serializer: UserSerializer
  has_one :updated_by_user, serializer: UserSerializer
  has_one :deleted_by_user, serializer: UserSerializer
  has_one :confirmed_by_user, serializer: UserSerializer
end
