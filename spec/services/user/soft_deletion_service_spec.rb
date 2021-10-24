require 'rails_helper'

RSpec.describe User::SoftDeletionService do
  describe '#call' do
    context 'when the user has deleted_at' do
      let(:user) { create(:user, :undeleted) }

      before { described_class.new(user).call }

      it { expect(user).to be_deleted }
    end
  end
end
