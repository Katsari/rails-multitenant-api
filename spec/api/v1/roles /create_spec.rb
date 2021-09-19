require 'rails_helper'

RSpec.describe 'roles#create', type: :request do
  subject(:make_request) do
    jsonapi_post '/api/v1/roles', payload, headers: auth_headers(user)
  end

  describe 'basic create' do
    let!(:user) { create(:user) }
    let!(:permission) { create(:permission) }

    let(:payload) do
      {
        data: {
          type: 'roles',
          attributes: {
            name: 'Supervisor'
          },
          relationships: {
            permissions: {
              data: [
                {
                  type: 'permissions',
                  id: permission.id.to_s
                }
              ]
            }
          }
        }
      }
    end

    it 'works' do
      expect(V1::RoleResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Role.count }.by(1)
    end
  end
end
