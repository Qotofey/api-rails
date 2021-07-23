require 'spec_helper'

shared_examples_for 'confirmable' do
  subject { create(described_class.to_s.underscore.to_sym, confirmation_mark) }

  let!(:confirmed) { { confirmed_at: Date.current, confirmed_by_user: create(:user) } }
  let!(:unconfirmed) { { confirmed_at: nil, confirmed_by_user: nil } }

  describe '#confirm' do
    before { subject.confirm }

    context 'when not confirmed' do
      let(:confirmation_mark) { unconfirmed.to_h }

      it { is_expected.to be_confirmed }
    end

    context 'when confirmed' do
      let(:confirmation_mark) { confirmed.to_h }

      it { is_expected.to be_confirmed }
    end
  end

  describe '#unconfirm' do
    before { subject.unconfirm }

    context 'when not confirmed' do
      let(:confirmation_mark) { unconfirmed.to_h }

      it { is_expected.not_to be_confirmed }
    end

    context 'when confirmed' do
      let(:confirmation_mark) { confirmed.to_h }

      it { is_expected.not_to be_confirmed }
    end
  end
end
