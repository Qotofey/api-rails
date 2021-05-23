require 'rails_helper'

RSpec.describe User, type: :model do
  it 'valid record' do
    expect(build(:user)).to be_valid
  end
end
