class Guide < ApplicationRecord
  belongs_to :post

  with_options presence: true, on: :publicize do
    validates :guide_image
    validates :body
  end

  attachment :guide_image
end