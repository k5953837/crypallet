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
class Transfer < ApplicationRecord
  # Scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  # Association macros
  belongs_to :from_user, class_name: 'User', foreign_key: :from_user_id
  belongs_to :to_user, class_name: 'User', foreign_key: :to_user_id

  # Association through macros

  # Validation macros
  validates :amount, presence: true, numericality: { greater_than: 0 }

  # Callbacks
  before_create :check_amount
  after_create :update_user_balance

  # Other

  private

  def check_amount
    return errors.add(:amount, 'must be less than balance') if amount > from_user.wallet.balance
  end

  def update_user_balance
    # process from_user balance
    from_wallet = from_user.wallet
    from_wallet.with_lock do
      from_wallet.balance -= amount
      from_wallet.save!
    end

    # process to_user balance
    to_wallet = to_user.wallet
    to_wallet.with_lock do
      to_wallet.balance += amount
      to_wallet.save!
    end
  end
end
