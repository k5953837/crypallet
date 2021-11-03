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
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
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
