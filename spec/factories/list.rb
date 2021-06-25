FactoryBot.define do
  factory :list do
    date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)} #=> "18/10/15 10:48"
    first_item { Faker::Lorem.characters(number:30) }
  end
end