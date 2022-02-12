# == Schema Information
#
# Table name: user_roles
#
#  id                 :bigint           not null, primary key
#  position           :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  created_by_user_id :bigint
#  updated_by_user_id :bigint
#  user_id            :bigint           not null
#
# Indexes
#
#  index_user_roles_on_created_by_user_id  (created_by_user_id)
#  index_user_roles_on_updated_by_user_id  (updated_by_user_id)
#  index_user_roles_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserRole, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
