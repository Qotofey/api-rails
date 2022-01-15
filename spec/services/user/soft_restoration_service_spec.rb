# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::SoftRestorationService, '#call' do
  let!(:user) { create(:user, :deleted, :confirmed) }

  before { described_class.new(user).call }

  it { expect(user).to_not be_deleted }
end
