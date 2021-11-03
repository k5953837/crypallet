# == Schema Information
#
# Table name: deposits
#
#  id         :bigint           not null, primary key
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_deposits_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Deposit, type: :model do
  # Initial variables

  # Associations specs
  context 'Associations specs' do
    it { should belong_to(:user) }
  end

  # Callbacks specs
  context 'Callbacks specs' do
    describe 'after_create' do
      it '#update_user_balance' do
        user = create(:user, :with_wallet)
        deposit = build :deposit, user: user
        deposit.send(:update_user_balance)
        expect(user.wallet.balance).to eq(deposit.amount)
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
