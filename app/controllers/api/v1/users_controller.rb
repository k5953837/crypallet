class Api::V1::UsersController < ApplicationController
  before_action :set_user

  def balance
    render json: { balance: @user.wallet.balance }
  end

  def deposit; end

  def withdraw; end

  def transfer; end

  private

  def user_params
    params.permit(:name)
  end

  def set_user
    @user = User.includes(:wallet).find(params[:id])
  end
end
