# == Schema Information
#
# Table name: transfers
#
#  id           :bigint           not null, primary key
#  amount       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  from_user_id :bigint           not null
#  to_user_id   :bigint           not null
#
# Indexes
#
#  index_transfers_on_from_user_id  (from_user_id)
#  index_transfers_on_to_user_id    (to_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (from_user_id => users.id)
#  fk_rails_...  (to_user_id => users.id)
#
require 'rails_helper'

RSpec.describe Transfer, type: :model do
  # Initial variables

  # Associations specs
  context 'Associations specs' do
    it { should belong_to(:from_user) }
    it { should belong_to(:to_user) }
  end

  # Callbacks specs
  context 'Callbacks specs' do
  end

  # Validations specs
  context 'Validations specs' do
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_presence_of(:amount) }
  end

  # Scopes specs
  context 'Scopes specs' do
  end

  # Callbacks specs
  context 'Callbacks specs' do
    describe 'before_create' do
      it '#check_amount' do
        user1 = create(:user, :with_wallet, :with_deposit)
        user2 = create(:user, :with_wallet, :with_deposit)
        transfer = build :transfer, from_user: user1, to_user: user2, amount: user1.wallet.balance + 1
        transfer.send(:check_amount)
        expect(transfer.errors.full_messages).to include('Amount must be less than balance')
      end
    end

    describe 'after_create' do
      it '#update_user_balance' do
        user1 = create(:user, :with_wallet, :with_deposit)
        user1_original_balance = user1.wallet.balance
        user2 = create(:user, :with_wallet, :with_deposit)
        user2_original_balance = user2.wallet.balance
        transfer_amount = user1_original_balance - 1
        transfer = build :transfer, from_user: user1, to_user: user2, amount: transfer_amount
        transfer.send(:update_user_balance)
        expect(user1.wallet.reload.balance).to eq(user1_original_balance - transfer_amount)
        expect(user2.wallet.reload.balance).to eq(user2_original_balance + transfer_amount)
      end
    end
  end

  # Instance methods specs
  context 'Instance method specs' do
  end
end
