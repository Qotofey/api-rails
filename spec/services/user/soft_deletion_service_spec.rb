# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::SoftDeletionService, '#call' do
  let!(:user) { create(:user, :undeleted, :confirmed) }

  context 'when called without admin' do
    before { described_class.new(user).call }

    it { expect(user).to be_deleted }
    it { expect(user.deleted_by_user_id).to be_nil }
  end

  context 'when called by admin' do
    let!(:admin) { create(:user, :undeleted, :confirmed) }

    before { described_class.new(user, admin).call }

    it { expect(user).to be_deleted }
    it { expect(user.deleted_by_user_id).to be(admin.id) }
  end
end
