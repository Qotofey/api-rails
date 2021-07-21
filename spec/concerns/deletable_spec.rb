require 'spec_helper'

shared_examples_for 'deletable' do
  subject { create(described_class.to_s.underscore.to_sym, deletion_mark) }
  let(:deleted) { { deleted_at: Date.current, deleted_by_user: create(:user) } }
  let(:undeleted) { { deleted_at: nil, deleted_by_user: nil } }

  describe '#soft_destroy' do
    before { subject.soft_destroy }

    context 'when not deleted' do
      let(:deletion_mark) { undeleted.to_h }

      it { is_expected.to be_deleted }
    end

    context 'when deleted' do
      let(:deletion_mark) { deleted.to_h }

      it { is_expected.to be_deleted }
    end
  end

  describe '#soft_restore' do
    before { subject.soft_restore }

    context 'when not deleted' do
      let(:deletion_mark) { undeleted.to_h }

      it { is_expected.not_to be_deleted }
    end

    context 'when deleted' do
      let(:deletion_mark) { deleted.to_h }

      it { is_expected.not_to be_deleted }
    end
  end
end
