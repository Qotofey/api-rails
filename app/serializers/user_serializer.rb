class UserSerializer < ActiveModel::Serializer
  attributes(%i[id login first_name middle_name last_name])
end
