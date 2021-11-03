# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  # Scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  # Association macros
  has_one :wallet, dependent: :destroy

  # Association through macros

  # Validation macros
  validates :name, presence: true

  # Callbacks

  # Other
end
