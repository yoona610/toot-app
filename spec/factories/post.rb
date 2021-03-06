FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    introduction { Faker::Lorem.characters(number: 15) }
    category_id { 1 }
    post_image_id { 1 }
    user_id { 1 }
    user
    category
  end
end
