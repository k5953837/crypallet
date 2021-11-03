require 'rails_helper'

RSpec.describe 'Api::V1::Wallets', type: :request do
  # initialize test data
  let!(:wallets) { create_list(:wallet, 2) }
  let(:user1) { wallets.first.user }
  let(:user2) { wallets.second.user }

  describe 'User can check her wallet balance' do
    it 'returns http success' do
      get "/api/v1/users/#{user1.id}/balance"

      expect(response).to have_http_status(:success)
      expect(json['balance']).to eq(user1.wallet.balance)
    end

    it "returns Couldn't find User error message when user_id is invalid_id" do
      get '/api/v1/users/invalid_id/balance'

      expect(response).to have_http_status(:not_found)
      expect(json['error']).to include("Couldn't find User with 'id'=invalid_id")
    end
  end
end
