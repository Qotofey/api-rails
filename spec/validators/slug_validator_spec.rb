# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SlugValidator do
  describe '#valid?' do
    context 'when set correct slug' do
      specify do
        expect(described_class.valid?('login')).to be_truthy
        expect(described_class.valid?('log_in')).to be_truthy
        expect(described_class.valid?('_login_')).to be_truthy
        expect(described_class.valid?('login0')).to be_truthy
        expect(described_class.valid?('7login')).to be_truthy
        expect(described_class.valid?('l')).to be_truthy
      end
    end

    context 'when set incorrect phone' do
      specify do
        expect(described_class.valid?('log.in')).to be_falsey
        expect(described_class.valid?(' login')).to be_falsey
        expect(described_class.valid?('log in')).to be_falsey
        expect(described_class.valid?('login ')).to be_falsey
        expect(described_class.valid?('login+')).to be_falsey
        expect(described_class.valid?('lo-gin')).to be_falsey
      end
    end
  end
end
