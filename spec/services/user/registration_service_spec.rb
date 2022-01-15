# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::RegistrationService, '#call' do
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
    end

    context '& confirmed' do
    end

    context '& deleted' do
    end
  end
end
