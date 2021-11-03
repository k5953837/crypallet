# == Schema Information
#
# Table name: withdraws
#
#  id         :bigint           not null, primary key
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_withdraws_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Withdraw, type: :model do
  # Initial variables

  # Associations specs
  context 'Associations specs' do
    it { should belong_to(:user) }
  end

  # Callbacks specs
  context 'Callbacks specs' do
    describe 'before_create' do
      it '#check_amount' do
        user = create(:user, :with_wallet, :with_deposit)
        withdraw = build :withdraw, user: user, amount: user.wallet.balance + 1
        withdraw.send(:check_amount)
        expect(withdraw.errors.full_messages).to include('Amount must be less than balance')
      end
    end

    describe 'after_create' do
      it '#update_user_balance' do
        user = create(:user, :with_wallet, :with_deposit)
        original_balance = user.wallet.balance
        withdraw_amount = Faker::Number.number(digits: 2)
        withdraw = build :withdraw, user: user, amount: withdraw_amount
        withdraw.send(:update_user_balance)
        expect(user.wallet.balance).to eq(original_balance - withdraw_amount)
      end
    end
  end

  # Validations specs
  context 'Validations specs' do
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_presence_of(:amount) }
  end

  # Scopes specs
  context 'Scopes specs' do
  end

  # Class methods specs
  context 'Class method specs' do
  end

  # Instance methods specs
  context 'Instance method specs' do
  end
end
