class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :post_image_id
      t.text :introduction
      t.boolean :commentable, default: false, null: false
      t.boolean :is_draft, default: false, null: false
      t.timestamps
    end
  end
end
