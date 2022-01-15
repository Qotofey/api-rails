# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmailValidator do
  describe '#valid?' do
    context 'when set correct email' do
      it { expect(described_class.valid?('aaa@aaa.aa')).to be_truthy }
    end

    context 'when set incorrect email' do
      it { expect(described_class.valid?('aaa@aaaaa')).to be_falsey }
    end
  end
end
