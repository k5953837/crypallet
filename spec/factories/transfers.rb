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
FactoryBot.define do
  factory :transfer do
    amount { Faker::Number.number(digits: 2) }
    from_user { create(:user, :with_wallet, :with_deposit) }
    to_user { create(:user, :with_wallet, :with_deposit) }
  end
end
