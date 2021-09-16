require 'rails_helper'

RSpec.feature 'ログイン前のテスト' do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }
  let!(:post) { FactoryBot.create(:post) }
  background do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_on 'ログイン'
  end

  feature '投稿画面のテスト' do
    background do
      visit admin_posts_path
    end
    scenario '有効会員の公開投稿のステータスが正常に表示される' do
      expect(page).to have_content '公開'
    end
    scenario '投稿詳細画面が正常に表示される' do
      click_on post.title
      expect(current_path).to eq admin_post_path(post)
    end
    scenario '投稿削除が正常に表示される' do
      click_on post.title
      click_on '投稿を削除'
      expect(current_path).to eq admin_posts_path
    end
  end

  feature '会員画面のテスト' do
    background do
      visit admin_users_path
    end
    scenario '有効会員の会員ステータスが正常に表示される' do
      expect(page).to have_content '有効'
    end
    scenario '会員詳細画面が正常に表示される' do
      click_on user.name
      expect(current_path).to eq admin_user_path(user)
    end
  end
end