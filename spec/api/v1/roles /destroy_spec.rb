require 'rails_helper'

RSpec.describe 'roles#destroy', type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/roles/#{role.id}", headers: auth_headers(user)
  end

  describe 'basic destroy' do
    let!(:user) { create(:user) }
    let!(:role) { create(:role) }

    it 'updates the resource' do
      expect(V1::RoleResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Role.count }.by(-1)
      expect { role.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end

  describe 'Destroy with user associated' do
    let!(:role) { create(:role) }
    let!(:user) { create(:user, role: role) }

    it 'Does NOT update the resource' do
      expect(V1::RoleResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(422), response.body
      }.to_not change { Role.count }
      expect { role.reload }
        .to_not raise_error
    end
  end
end
