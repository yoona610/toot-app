class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.references :chat_room, foreign_key: true
      t.references :user, foreign_key: true
      t.references :admin, foreign_key: true
      t.boolean :is_admin, default: false, null: false
      t.text :message, null: false
      t.timestamps
    end
  end
end
