class Users::ShowSerializer < ActiveModel::Serializer
  attributes(%i[id login first_name middle_name last_name phone email birth_date gender])
end
