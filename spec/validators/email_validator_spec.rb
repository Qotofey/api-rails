require 'rails_helper'

RSpec.describe EmailValidator do
  context 'when set valid email' do
    it { expect(described_class.valid?('aaa@aaa.aa')).to be_truthy }
  end
end
