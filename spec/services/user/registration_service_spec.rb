require 'rails_helper'

RSpec.describe User::RegistrationService do
  describe '#call' do
    let(:valid_attributes) { attributes_for(:user, :unconfirmed) }

    context 'when the users is not yet created' do
      it 'creates a new users' do
        expect do
          described_class.new(valid_attributes).call
        end.to change(User, :count).by(1)
      end
    end

    context 'when the users is already created' do
      context '& not confirmed' do
      end

      context '& confirmed' do
      end

      context '& deleted' do
      end
    end
  end
end
