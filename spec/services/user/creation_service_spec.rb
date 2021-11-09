require 'rails_helper'

RSpec.describe User::CreationService, '#call' do
  let(:valid_attributes) { attributes_for(:user, :unconfirmed) }

  context 'when the user is not yet created' do
    it 'creates a new user' do
      expect do
        described_class.new(valid_attributes).call
      end.to change(User, :count).by(1)
    end
  end

  context 'when the user is already created' do
    context '& not confirmed' do
      before { create(:user, valid_attributes) }

      it 'does not create a new user' do
        expect do
          described_class.new(valid_attributes).call
        end.to change(User, :count).by(0)
      end
    end

    context '& confirmed' do
      let(:valid_attributes) { attributes_for(:user, :confirmed) }

      before { create(:user, valid_attributes) }

      it 'does not create a new user' do
        expect do
          described_class.new(valid_attributes).call
        end.to change(User, :count).by(0)
      end
    end

    context '& deleted' do
      before { create(:user, valid_attributes) }

      it 'does not create a new user' do
        expect do
          described_class.new(valid_attributes).call
        end.to change(User, :count).by(0)
      end
    end
  end
end
