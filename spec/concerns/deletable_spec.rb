require 'spec_helper'

shared_examples_for 'deletable' do
  subject { described_class }

  describe '#soft_destroy' do
    context 'when not deleted' do
      it { expect(subject.soft_destroy).to be_deleted }
    end

    context 'when already deleted' do
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
