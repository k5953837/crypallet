class Api::V1::UsersController < ApplicationController
  before_action :set_user

  def balance
    render json: { balance: @user.wallet.balance }
  end

  def deposit
    deposit = @user.deposits.new(amount: params[:amount].to_i)
    if deposit.save
      render json: { balance: @user.wallet.balance }
    else
      render json: { errors: deposit.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def transfer; end

  def withdraw
    withdraw = @user.withdraws.new(amount: params[:amount].to_i)
    if withdraw.save
      render json: { balance: @user.wallet.balance }
    else
      render json: { errors: withdraw.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name)
  end

  def set_user
    @user = User.includes(:wallet).find(params[:id])
  end
end
