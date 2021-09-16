class InitSchema < ActiveRecord::Migration[5.2]
  def up
    create_table "activities" do |t|
      t.integer "user_id"
      t.string "subject_type"
      t.integer "subject_id"
      t.integer "action_type", null: false
      t.boolean "activity_status", default: false, null: false
      t.boolean "read", default: false, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["subject_type", "subject_id"], name: "index_activities_on_subject_type_and_subject_id"
      t.index ["user_id"], name: "index_activities_on_user_id"
    end
    create_table "admins" do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["email"], name: "index_admins_on_email", unique: true
      t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    end
    create_table "bookmarks" do |t|
      t.integer "user_id"
      t.integer "post_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["post_id"], name: "index_bookmarks_on_post_id"
      t.index ["user_id"], name: "index_bookmarks_on_user_id"
    end
    create_table "categories" do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "chat_rooms" do |t|
      t.integer "user_id"
      t.boolean "response_status", default: false, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_chat_rooms_on_user_id"
    end
    create_table "chats" do |t|
      t.integer "chat_room_id"
      t.integer "user_id"
      t.integer "admin_id"
      t.boolean "is_admin", default: false, null: false
      t.text "message", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["admin_id"], name: "index_chats_on_admin_id"
      t.index ["chat_room_id"], name: "index_chats_on_chat_room_id"
      t.index ["user_id"], name: "index_chats_on_user_id"
    end
    create_table "comments" do |t|
      t.integer "user_id"
      t.integer "post_id"
      t.float "rate", default: 0.0
      t.text "comment"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["post_id"], name: "index_comments_on_post_id"
      t.index ["user_id"], name: "index_comments_on_user_id"
    end
    create_table "guides" do |t|
      t.integer "post_id"
      t.string "guide_image_id"
      t.text "body"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["post_id"], name: "index_guides_on_post_id"
    end
    create_table "histories" do |t|
      t.integer "user_id"
      t.integer "post_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["post_id"], name: "index_histories_on_post_id"
      t.index ["user_id"], name: "index_histories_on_user_id"
    end
    create_table "ingredients" do |t|
      t.integer "post_id"
      t.string "name"
      t.string "shop_name"
      t.integer "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["post_id"], name: "index_ingredients_on_post_id"
    end
    create_table "likes" do |t|
      t.integer "user_id"
      t.integer "post_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["post_id"], name: "index_likes_on_post_id"
      t.index ["user_id"], name: "index_likes_on_user_id"
    end
    create_table "posts" do |t|
      t.integer "user_id"
      t.integer "category_id"
      t.string "title"
      t.string "post_image_id"
      t.text "introduction"
      t.boolean "commentable", default: false, null: false
      t.boolean "is_draft", default: false, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["category_id"], name: "index_posts_on_category_id"
      t.index ["user_id"], name: "index_posts_on_user_id"
    end
    create_table "relationships" do |t|
      t.integer "follower_id"
      t.integer "followed_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["followed_id"], name: "index_relationships_on_followed_id"
      t.index ["follower_id"], name: "index_relationships_on_follower_id"
    end
    create_table "users" do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.string "name", null: false
      t.string "profile_image_id"
      t.text "introduction"
      t.boolean "is_deleted", default: false, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
