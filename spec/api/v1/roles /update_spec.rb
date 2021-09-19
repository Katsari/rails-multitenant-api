require 'rails_helper'

RSpec.describe 'roles#update', type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/roles/#{role.id}", payload, headers: auth_headers(user)
  end

  describe 'basic update' do
    let!(:user) { create(:user) }
    let!(:role) { create(:role) }

    let(:payload) do
      {
        data: {
          id: role.id.to_s,
          type: 'roles',
          attributes: {
            name: 'Supervisor'
          }
        }
      }
    end

    it 'updates the resource' do
      expect(V1::RoleResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { role.reload.attributes }
      .and change { role.name }.to('Supervisor')
    end
  end
end
