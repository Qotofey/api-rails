class Users::RecoverySerializer < ApplicationSerializer
  attributes(%i[id email updated_at])
end
