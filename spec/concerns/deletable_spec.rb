require 'spec_helper'

shared_examples_for 'deletable' do
  subject { create(described_class.to_s.underscore.to_sym) }

  describe '#soft_destroy' do
    context 'when not deleted' do
      before { subject.soft_destroy }

      it 'is checked as deleted on soft delete' do
        is_expected.to be_deleted
      end
    end
  end

  # describe '#soft_restore' do
  #   context 'when model deleted' do
  #     before { subject.soft_restore }
  #
  #     it { is_expected.to be_deleted }
  #   end
  #
  #   context 'when model not deleted' do
  #     it { is_expected.not_to be_deleted }
  #   end
  # end
end
