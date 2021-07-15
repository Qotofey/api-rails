# == Schema Information
#
# Table name: roles
#
#  id                 :bigint           not null, primary key
#  position           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  created_by_user_id :bigint
#  updated_by_user_id :bigint
#  user_id            :bigint           not null
#
# Indexes
#
#  index_roles_on_created_by_user_id  (created_by_user_id)
#  index_roles_on_updated_by_user_id  (updated_by_user_id)
#  index_roles_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :role do
    position { 1 }
    user { nil }
  end
end
