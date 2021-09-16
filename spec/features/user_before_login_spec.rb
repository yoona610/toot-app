require 'rails_helper'

RSpec.feature 'ログイン前のテスト' do
  let!(:user) { create(:user) }
  let!(:post) { FactoryBot.create(:post) }

  feature 'トップ画面のテスト' do
    background do
      visit root_path
    end
    scenario '投稿名を押下し、投稿詳細ページに遷移する' do
      click_on post.title
      expect(current_path).to eq post_path(post)
    end
    scenario '会員名を押下し、会員詳細ページに遷移する' do
      click_on post.user.name
      expect(current_path).to eq user_path(post.user)
    end
  end

  feature '投稿詳細画面のテスト' do
    background do
      visit post_path(post)
    end
    scenario '会員名を押下する' do
      click_on post.user.name
      expect(current_path).to eq user_path(post.user)
    end
    scenario '投稿編集ボタンが表示されていない' do
      expect(page).to_not have_link nil, href: edit_post_path(post)
    end
    scenario '投稿編集画面に直接URLからアクセスした場合、ログイン画面に遷移する' do
      visit edit_post_path(post)
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'アカウント登録もしくはログインしてください。'
    end
  end

  feature '会員詳細画面のテスト' do
    background do
      visit user_path(post.user.id)
    end
    scenario '遷移先の会員の投稿タブが表示される' do
      expect(page).to have_content '投稿'
    end
    scenario '遷移先の会員のいいねタブが表示される' do
      expect(page).to have_content 'いいね'
    end
    scenario '遷移先の会員の閲覧履歴タブが表示されない' do
      expect(page).to_not have_content '閲覧履歴'
    end
    scenario '遷移先の会員に対するフォローボタンが表示されない' do
      expect(page).to_not have_button 'Follow'
    end
    scenario '遷移先の会員に対するフォロー中タブが表示されない' do
      expect(page).to_not have_button 'Unfollow'
    end
    scenario '会員編集ボタンが表示されていない' do
      expect(page).to_not have_link nil, href: edit_user_path(post.user)
    end
    scenario '会員編集画面に直接URLからアクセスした場合、ログイン画面に遷移する' do
      visit edit_user_path(post.user)
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'アカウント登録もしくはログインしてください。'
    end
  end

  feature 'ヘッダーのテスト' do
    background do
      visit posts_path
    end
    scenario 'ロゴを押下し、トップ画面に遷移する' do
      click_on 'TOOT'
      expect(current_path).to eq root_path
    end
    scenario 'ABOUTを押下し、アバウト画面に遷移する' do
      click_on 'ABOUT'
      expect(current_path).to eq about_path
    end
    scenario 'SIGN UPを押下し、会員登録画面に遷移する' do
      click_on 'サインアップ'
      expect(current_path).to eq new_user_registration_path
    end
    scenario 'SIGN INを押下し、ログイン画面に遷移する' do
      click_on 'サインイン'
      expect(current_path).to eq new_user_session_path
    end
  end

  feature '会員ログインのテスト' do
    before do
      visit new_user_session_path
    end
    scenario 'ログイン成功の場合' do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_on 'Sign in'
      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'ログインしました'
    end
    scenario 'ログイン失敗の場合' do
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: user.password
      click_on 'Sign in'
      expect(page).to have_content 'Eメールまたはパスワードが違います'
    end
  end
end