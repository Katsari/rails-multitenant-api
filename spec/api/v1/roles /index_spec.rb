require 'rails_helper'

RSpec.describe 'roles#index', type: :request do
  subject(:make_request) do
    jsonapi_get '/api/v1/roles', headers: auth_headers(user)
  end

  describe 'basic fetch' do
    let!(:role1) { create(:role) }
    let!(:role2) { create(:role) }
    let!(:user) { create(:user, role: role1) }

    it 'works' do
      expect(V1::RoleResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['roles'])
      expect(d.map(&:id)).to match_array([role1.id, role2.id])
    end
  end
end
