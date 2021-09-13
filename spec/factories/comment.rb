FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.characters(number:35) }
    user
    post
  end
end