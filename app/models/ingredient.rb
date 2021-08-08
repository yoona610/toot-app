class Ingredient < ApplicationRecord
  belongs_to :post

  with_options presence: true, on: :publicize do
    validates :name
    validates :shop_name
    validates :price
  end

end
