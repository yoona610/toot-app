FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.characters(number: 35) }
    rate { 5 }
    user
    post
  end
end
