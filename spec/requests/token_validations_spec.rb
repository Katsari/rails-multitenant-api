require 'rails_helper'

RSpec.describe 'Token Validations', type: :request do
  describe 'signed in' do
    let(:user) { create(:user) }
    sign_in(:user)

    it 'returns success status' do
      get '/auth/validate_token'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'signed out' do
    it 'returns unauthorized status' do
      get '/auth/validate_token'
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
