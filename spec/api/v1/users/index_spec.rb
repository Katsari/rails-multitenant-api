require 'rails_helper'

RSpec.describe 'users#index', type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let(:url) { '/api/v1/users' }

  subject(:make_request) do
    jsonapi_get url, headers: auth_headers(user1)
  end

  describe 'basic fetch' do
    it 'works' do
      expect(V1::UserResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['users'])
      expect(d.map(&:id)).to match_array([user1.id, user2.id])
    end
  end
end
