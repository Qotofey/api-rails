class Users::ConfirmationSerializer < ApplicationSerializer
  attributes(%i[id email confirmed_at])
end