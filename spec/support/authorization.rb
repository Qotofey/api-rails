RSpec.shared_examples 'authorize user' do
  let(:current_user) { create(:user) }

  before { ApplicationRecord.active_user = current_user }
end