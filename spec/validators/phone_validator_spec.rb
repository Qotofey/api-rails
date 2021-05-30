require 'rails_helper'

RSpec.describe PhoneValidator do
  context 'when set valid phone' do
    it { expect(described_class.valid?('79990000000')).to be_truthy }
    it { expect(described_class.valid?('73990000000')).to be_truthy }
    it { expect(described_class.valid?('74990000000')).to be_truthy }
  end

  context 'when set not valid phone' do
    it { expect(described_class.valid?('00000000')).to be_falsey }
    it { expect(described_class.valid?('30080280783С')).to be_falsey }
  end
end
