require 'rails_helper'

RSpec.describe 'users#update', type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/users/#{user.id}", payload, headers: auth_headers(user)
  end

  describe 'basic update' do
    let!(:user) { create(:user) }
    let(:password) { Faker::Internet.password }

    let(:payload) do
      {
        data: {
          id: user.id.to_s,
          type: 'users',
          attributes: {
            username: 'fernando',
            name: Faker::Name.first_name,
            password: password,
            password_confirmation: password,
            email: Faker::Internet.unique.email
          }
        }
      }
    end

    it 'updates the resource' do
      expect(V1::UserResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { user.reload.attributes }
      .and change { user.username }.to('fernando')
    end
  end
end
