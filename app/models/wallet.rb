# == Schema Information
#
# Table name: wallets
#
#  id         :bigint           not null, primary key
#  balance    :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_wallets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Wallet < ApplicationRecord
  # Scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  # Association macros
  belongs_to :user

  # Association through macros

  # Validation macros
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Callbacks

  # Other
end
