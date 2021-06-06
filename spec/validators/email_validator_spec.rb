require 'rails_helper'

RSpec.describe EmailValidator do
  context 'when set valid name' do
    it { expect(described_class.valid?('aaa@aaa.aa')).to be_truthy }
  end
end
