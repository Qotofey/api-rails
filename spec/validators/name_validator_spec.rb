require 'rails_helper'

RSpec.describe NameValidator do
  context 'when set valid name' do
    it { expect(described_class.valid?('Игорь')).to be_truthy }
    it { expect(described_class.valid?('Андрей')).to be_truthy }
    it { expect(described_class.valid?('Алексей')).to be_truthy }
    it { expect(described_class.valid?('сюзана')).to be_truthy }
    it { expect(described_class.valid?('сюзана')).to be_truthy }
    it { expect(described_class.valid?('В')).to be_truthy }
    it { expect(described_class.valid?('ф')).to be_truthy }
  end

  context 'when set not valid name' do
    it { expect(described_class.valid?(' Игорь')).to be_falsey }
    it { expect(described_class.valid?('Иг0рь')).to be_falsey }
    it { expect(described_class.valid?(' Алексей ')).to be_falsey }
    it { expect(described_class.valid?('Алан_')).to be_falsey }
    it { expect(described_class.valid?('9')).to be_falsey }
    it { expect(described_class.valid?('В.')).to be_falsey }
  end
end
