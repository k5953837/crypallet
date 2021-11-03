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
FactoryBot.define do
  factory :wallet do
    balance { 1 }
    user { nil }
  end
end
