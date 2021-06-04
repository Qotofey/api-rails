class Users::IndexSerializer < UserSerializer
  attributes %i[id promo first_name last_name middle_name email phone birth_date gender
                confirmed_at deleted_at created_at updated_at]
end
