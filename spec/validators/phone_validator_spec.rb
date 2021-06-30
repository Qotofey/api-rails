require 'rails_helper'

RSpec.describe PhoneValidator do
  describe '#valid?' do
    context 'when set correct phone' do
      it { expect(described_class.valid?('79990000000')).to be_truthy }
      it { expect(described_class.valid?('73990000000')).to be_truthy }
      it { expect(described_class.valid?('74000000000')).to be_truthy }
      it { expect(described_class.valid?('78000000000')).to be_truthy }
    end

    context 'when set incorrect phone' do
      it { expect(described_class.valid?('790000000000')).to be_falsey }
      it { expect(described_class.valid?('70000000000')).to be_falsey }
      it { expect(described_class.valid?('74u00000000')).to be_falsey }
      it { expect(described_class.valid?('89990000000')).to be_falsey }
      it { expect(described_class.valid?('7 999 000 0000')).to be_falsey }
      it { expect(described_class.valid?('+79990000000')).to be_falsey }
    end
  end
end
