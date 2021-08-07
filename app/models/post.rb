class Post < ApplicationRecord
  belongs_to :user
  attachment :post_image

  with_options presence: true, on: :publicize do
    validates :title
    validates :post_image_id
    validates :introduction
  end
    validates :title, length: { maximum: 14 }, on: :publicize
    validates :introduction, length: { maximum: 80 }, on: :publicize
end
