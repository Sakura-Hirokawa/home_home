FactoryBot.define do
  factory :list do
    date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    first_item { Faker::Lorem.characters(number: 30) }
  end
end
