# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }

    trait :with_wallet do
      after(:create) do |user|
        create :wallet, user: user
      end
    end

    trait :with_deposit do
      after(:create) do |user|
        create :deposit, user: user
      end
    end
  end
end
