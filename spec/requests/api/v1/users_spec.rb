require 'rails_helper'

RSpec.describe 'Api::V1::Wallets', type: :request do
  # initialize test data
  let(:user1) { create(:user, :with_wallet, :with_deposit) }
  let(:user2) { create(:user, :with_wallet, :with_deposit) }

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

    it "returns 'Amount must be greater than 0' when amount less than 1" do
      post "/api/v1/users/#{user1.id}/deposit", params: { amount: -1 }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['errors']).to include('Amount must be greater than 0')
    end
  end

  describe 'User can send money to another user' do
    let!(:user1_original_balance) { user1.wallet.balance }
    let!(:user2_original_balance) { user2.wallet.balance }
    let(:transfer_params) do
      { amount: user1_original_balance - 1, to_user_id: user2.id }
    end

    it 'returns http success' do
      post "/api/v1/users/#{user1.id}/transfer", params: transfer_params

      expect(response).to have_http_status(:success)
      expect(json['balance']).to eq(user1_original_balance - transfer_params[:amount].to_i)
      expect(user2.reload.wallet.balance).to eq(user2_original_balance + transfer_params[:amount].to_i)
    end

    it "returns 'Couldn't find User' when user_id is invalid_id" do
      post '/api/v1/users/invalid_id/transfer', params: transfer_params

      expect(response).to have_http_status(:not_found)
      expect(json['error']).to include("Couldn't find User with 'id'=invalid_id")
    end

    it "returns 'Couldn't find User' when to_user_id is invalid_id" do
      post "/api/v1/users/#{user1.id}/transfer", params: { amount: user1.wallet.balance - 1, to_user_id: 'invalid_id' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['errors']).to include('To user must exist')
    end

    it "returns 'Amount must be greater than 0' when amount does not present" do
      post "/api/v1/users/#{user1.id}/transfer", params: { amount: '' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['errors']).to include('Amount must be greater than 0')
    end

    it "returns 'Amount must be greater than 0' when amount less than 1" do
      post "/api/v1/users/#{user1.id}/transfer", params: { amount: -1 }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['errors']).to include('Amount must be greater than 0')
    end

    it "returns 'Amount must be less than balance' when amount greater than balance" do
      post "/api/v1/users/#{user1.id}/transfer", params: { amount: user1.wallet.balance + 1, to_user_id: user2.id }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['errors']).to include('Amount must be less than balance')
    end
  end

  describe 'User can withdraw money from her wallet' do
    let!(:original_balance) { user1.wallet.balance }
    let(:withdraw_params) do
      { amount: user1.wallet.balance - 1 }
    end

    it 'returns http success' do
      post "/api/v1/users/#{user1.id}/withdraw", params: withdraw_params

      expect(response).to have_http_status(:success)
      expect(json['balance']).to eq(original_balance - withdraw_params[:amount].to_i)
    end

    it "returns 'Couldn't find User' when user_id is invalid_id" do
      post '/api/v1/users/invalid_id/withdraw', params: withdraw_params

      expect(response).to have_http_status(:not_found)
      expect(json['error']).to include("Couldn't find User with 'id'=invalid_id")
    end

    it "returns 'Amount must be greater than 0' when amount does not present" do
      post "/api/v1/users/#{user1.id}/withdraw", params: { amount: '' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['errors']).to include('Amount must be greater than 0')
    end

    it "returns 'Amount must be greater than 0' when amount less than 1" do
      post "/api/v1/users/#{user1.id}/withdraw", params: { amount: -1 }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['errors']).to include('Amount must be greater than 0')
    end

    it "returns 'Amount must be less than balance' when amount greater than balance" do
      post "/api/v1/users/#{user1.id}/withdraw", params: { amount: user1.wallet.balance + 1 }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['errors']).to include('Amount must be less than balance')
    end
  end
end
