require 'rails_helper'

RSpec.describe User::SoftRestorationService, '#call' do
  context 'when deleted_at is nil' do
    let!(:user) { create(:user, :undeleted) }

    before { described_class.new(user).call }

    it { expect(user).to_not be_deleted }
  end

  context 'when deleted_at is not nil' do
    let!(:user) { create(:user, :deleted) }

    before { described_class.new(user).call }

    it { expect(user).to_not be_deleted }
  end
end
