# == Schema Information
#
# Table name: user
#
#  id                   :bigint           not null, primary key
#  birth_date           :date
#  confirmed_at         :datetime
#  deleted_at           :datetime
#  email                :string(255)
#  first_name           :string(255)
#  gender               :string(255)
#  last_name            :string(255)
#  middle_name          :string(255)
#  password_digest      :string(255)
#  phone                :string(255)
#  promo                :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  confirmed_by_user_id :bigint
#  created_by_user_id   :bigint
#  deleted_by_user_id   :bigint
#  updated_by_user_id   :bigint
#
# Indexes
#
#  index_users_on_confirmed_by_user_id  (confirmed_by_user_id)
#  index_users_on_created_by_user_id    (created_by_user_id)
#  index_users_on_deleted_by_user_id    (deleted_by_user_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_phone                 (phone) UNIQUE
#  index_users_on_promo                 (promo) UNIQUE
#  index_users_on_updated_by_user_id    (updated_by_user_id)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when signed up' do
    subject(:registered_user) { create(:user, :unconfirmed) }

    it { is_expected.not_to be_confirmed }
    it { is_expected.not_to be_deleted }

    # context 'by admin' do
    #   it 'sets a non-empty created_by_user_id'
    #   it 'sets a non-empty updated_by_user_id'
    # end
  end

  describe '#full_name' do
    subject(:user) { build(:user, full_name_attrs) }

    context 'with middle_name' do
      let!(:full_name_attrs) { { first_name: 'Robert', middle_name: 'Cecil', last_name: 'Martin' } }

      it { expect(user.full_name.count(' ')).to eq(2) }
    end

    context 'without middle_name' do
      let!(:full_name_attrs) { { first_name: 'Robert', middle_name: '', last_name: 'Martin' } }

      it { expect(user.full_name.count(' ')).to eq(1) }
    end
  end

  # it_behaves_like 'confirmable'
  # it_behaves_like 'deletable'
end
