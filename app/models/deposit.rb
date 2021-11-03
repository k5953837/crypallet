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
class Deposit < ApplicationRecord
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
  after_create :update_user_balance

  # Other

  private

  def update_user_balance
    wallet = user.wallet
    wallet.with_lock do
      wallet.balance += amount
      wallet.save!
    end
  end
end
