FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.characters(number:35) }
    user
  end
end