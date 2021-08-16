class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.references :subject, polymorphic: true
      t.integer :action_type, null: false
      t.boolean :activity_status, null: false, default: false
      t.boolean :read, null: false, default: false
      t.timestamps
    end
  end
end
