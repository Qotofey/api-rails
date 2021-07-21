# == Schema Information
#
# Table name: users
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
  it_behaves_like 'deletable'
  it_behaves_like 'confirmable'

  context 'when signed up' do
    subject(:registered_user) { create(:user, :unconfirmed) }

    it { is_expected.not_to be_confirmed }
    it { is_expected.not_to be_deleted }

    context 'by admin' do
      it 'sets a non-empty created_by_user_id'
      it 'sets a non-empty updated_by_user_id'
    end
  end

  describe '#confirm' do
    context 'with admin panel' do
      it 'sets a non-empty confirmed_by_user_id'
      it 'sets a non-empty confirmed_at'
    end

    context 'without admin panel' do
      it 'sets an empty confirmed_by_user_id'
      it 'sets a non-empty confirmed_at'
    end
  end

  describe '#unconfirm' do
    context 'with admin panel' do
      it 'sets an empty confirmed_by_user_id'
      it 'sets an empty confirmed_at'
    end

    context 'without admin panel' do
      it 'sets an empty confirmed_by_user_id'
      it 'sets an empty confirmed_at'
    end
  end

  describe '#full_name' do
    subject(:user) { create(:user) }

    context 'with middle_name' do
      it 'should be include two spaces'
    end

    context 'without middle_name' do
      it 'should be include a space'
    end
  end
end
