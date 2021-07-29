require 'rails_helper'

RSpec.describe '/v1/users/sign_in', type: :request do
  let(:valid_headers) { {} }
  let(:valid_attributes) { { email: 'test@qotofey.ru', password: 'Password123' } }

  before { create(:user, valid_attributes) }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'respond with 201'

      it do
        post v1_users_sign_in_url, params: { sign_in: valid_attributes }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
      end
    end

    context 'with valid email' do
      it 'responds with 400'
    end
  end
end
