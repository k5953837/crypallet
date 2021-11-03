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
class Withdraw < ApplicationRecord
  # Scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  # Association macros
  belongs_to :user

  # Association through macros

  # Validation macros
  validates :amount, presence: true, numericality: { greater_than: 0 }

  # Callbacks
  before_create :check_amount
  after_create :update_user_balance

  # Other

  private

  def check_amount
    return errors.add(:amount, 'must be less than balance') if amount > user.wallet.balance
  end

  def update_user_balance
    wallet = user.wallet
    wallet.with_lock do
      wallet.balance -= amount
      wallet.save!
    end
  end
end
