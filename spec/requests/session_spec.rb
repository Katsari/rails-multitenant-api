require 'rails_helper'

RSpec.describe 'Session', type: :request do
  before(:each) do
    @user =  FactoryBot.create(:user)
    @sign_in_url = '/api/v1/auth/sign_in'
    @sign_out_url = '/api/v1/auth/sign_out'
    @login_params = {
        email: @user.email,
        password: @user.password
    }
  end

  describe 'POST /api/v1/auth/sign_in' do
    context 'when login params is valid' do
      before do
        login
      end

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns access-token in authentication header' do
        expect(response.headers['access-token']).to be_present
      end

      it 'returns client in authentication header' do
        expect(response.headers['client']).to be_present
      end

      it 'returns expiry in authentication header' do
        expect(response.headers['expiry']).to be_present
      end

      it 'returns uid in authentication header' do
        expect(response.headers['uid']).to be_present
      end
    end

    context 'when login params is invalid' do
      before { post @sign_in_url }

      it 'returns unathorized status 401' do
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE /api/v1/auth/sign_out' do
    before do
      login
      @headers = {
        'uid' => response.headers['uid'],
        'client' => response.headers['client'],
        'access-token' => response.headers['access-token']
      }
    end

    it 'returns status 200' do
      delete @sign_out_url, headers: @headers
      expect(response).to have_http_status(200)
    end
  end

  def login
    post @sign_in_url, params: @login_params, as: :json
  end
end
