class CreateGuides < ActiveRecord::Migration[5.2]
  def change
    create_table :guides do |t|
      t.references :post, foreign_key: true
      t.string :guide_image_id
      t.text :body
      t.timestamps
    end
  end
end
