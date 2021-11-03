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

  describe 'User can deposit money into her wallet' do
    let!(:original_balance) { user1.wallet.balance }
    let(:deposit_params) do
      { amount: Faker::Number.number(digits: 3) }
    end

    it 'returns http success' do
      post "/api/v1/users/#{user1.id}/deposit", params: deposit_params

      expect(response).to have_http_status(:success)
      expect(json['balance']).to eq(original_balance + deposit_params[:amount].to_i)
    end

    it "returns 'Couldn't find User' when user_id is invalid_id" do
      post '/api/v1/users/invalid_id/deposit', params: deposit_params

      expect(response).to have_http_status(:not_found)
      expect(json['error']).to include("Couldn't find User with 'id'=invalid_id")
    end

    it "returns 'Amount must be greater than 0' when amount does not present" do
      post "/api/v1/users/#{user1.id}/deposit", params: { amount: '' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['errors']).to include('Amount must be greater than 0')
    end

    it 'returns amount must greater than 0 error message when amount less than 1' do
      post "/api/v1/users/#{user1.id}/deposit", params: { amount: -1 }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['errors']).to include('Amount must be greater than 0')
    end
  end

  describe 'User can send money to another user' do
  end

  describe 'User can withdraw money from her wallet' do
  end
end
