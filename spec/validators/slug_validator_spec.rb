require 'rails_helper'

RSpec.describe SlugValidator do
  context 'when set valid slug' do
    it { expect(described_class.valid?('login')).to be_truthy }
    it { expect(described_class.valid?('log_in')).to be_truthy }
    it { expect(described_class.valid?('_login_')).to be_truthy }
    it { expect(described_class.valid?('login0')).to be_truthy }
    it { expect(described_class.valid?('7login')).to be_truthy }
    it { expect(described_class.valid?('l')).to be_truthy }
  end

  context 'when set not valid phone' do
    it { expect(described_class.valid?('log.in')).to be_falsey }
    it { expect(described_class.valid?(' login')).to be_falsey }
    it { expect(described_class.valid?('log in')).to be_falsey }
    it { expect(described_class.valid?('login ')).to be_falsey }
    it { expect(described_class.valid?('login+')).to be_falsey }
    it { expect(described_class.valid?('lo-gin')).to be_falsey }
  end
end
