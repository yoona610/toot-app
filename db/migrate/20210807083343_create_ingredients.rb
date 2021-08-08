class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.references :post, foreign_key: true
      t.string :name
      t.string :shop_name
      t.integer :price
      t.timestamps
    end
  end
end
