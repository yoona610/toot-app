crumb :root do
  link "Home", root_path
end

# ========== 会員関連 ===========

crumb :user_show do |user|
  link "#{user.name}さんのページ", user_path(user)
  parent :root
end

crumb :user_edit do |user|
  link "プロフィール編集", edit_user_path(user)
  parent :user_show, user
end

crumb :user_unsubscribe do |user|
  link "退会", users_unsubscribe_path(user)
  parent :user_edit, user
end

crumb :user_follow do |user|
  link "#{user.name}さんのフォロー", follows_user_path(user)
  parent :user_show, user
end

crumb :user_follower do |user|
  link "#{user.name}さんのフォロワー", followers_user_path(user)
  parent :user_show, user
end

#========== 投稿関連 ===========

crumb :post_show do |post|
  link "#{post.title}", post_path(post)
  parent :root
end

crumb :post_edit do |post|
  link "投稿編集", edit_post_path(post)
  parent :post_show, post
end

crumb :latest_posts do
  link "新着投稿", posts_path
  parent :root
end

crumb :new_post do
  link "新規投稿", new_post_path
  parent :root
end

crumb :popular_posts do
  link "TOP10", posts_rankings_path
  parent :root
end

# ========== 問い合わせ・通知関連 ===========

crumb :chat_inquiry do
  link "お問い合わせ", chats_path
  parent :root
end

crumb :activity do
  link "通知", activities_path
  parent :root
end