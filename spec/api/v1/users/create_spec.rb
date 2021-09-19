require 'rails_helper'

RSpec.describe 'users#create', type: :request do
  subject(:make_request) do
    jsonapi_post '/api/v1/users', payload, headers: auth_headers(user)
  end

  describe 'basic create' do
    let!(:user) { create(:user) }
    let!(:role) { create(:role) }

    let(:payload) do
      {
        data: {
          type: 'users',
          attributes: {
            username: 'daniela',
            name: 'Daniela Guarecuco',
            password: '123456',
            password_confirmation: '123456',
            email: 'daniela.guarecuco@agromatic.com.ve'
          },
          relationships: {
            role: {
              data: {
                type: 'roles',
                id: role.id.to_s
              }
            }
          }
        }
      }
    end

    it 'works' do
      expect(V1::UserResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { User.count }.by(1)
    end
  end
end
