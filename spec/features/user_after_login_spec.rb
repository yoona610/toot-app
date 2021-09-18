require 'rails_helper'

RSpec.feature 'ログイン後のテスト' do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { FactoryBot.create(:post, user_id: user.id) }
  let!(:post2) { FactoryBot.create(:post, user_id: other_user.id, title: 'test2') }
  background do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Sign in'
  end

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
    scenario '投稿者＝ログイン会員の場合、投稿編集ボタンが表示されている' do
      expect(page).to have_link '投稿を編集', href: edit_post_path(post)
    end
    scenario '投稿者≠ログイン会員の場合、投稿編集ボタンが表示されない' do
      expect(page).not_to have_link '投稿を編集', href: edit_post_path(post2)
    end
    scenario '投稿編集ボタンから、編集画面に遷移する' do
      click_on '投稿を編集'
      expect(current_path).to eq edit_post_path(post)
    end
  end

  feature '投稿編集画面のテスト（公開済み）' do
    background do
      post.ingredients.create(name: '材料名', shop_name: '店名', price: '110')
      post.guides.create(guide_image_id: '1', body: '使い方')
      visit edit_post_path(post)
    end
    scenario '編集内容が正しく更新される' do
      fill_in 'post[title]', with: post.title
      click_button '投稿を更新'
      expect(page).to have_content '投稿を更新しました！'
    end
  end

  feature '会員詳細画面のテスト（マイページ）' do
    background do
      visit user_path(user)
    end
    scenario '投稿レシピが表示される' do
      expect(page).to have_content post.title
    end
    scenario 'いいねタブが表示される' do
      expect(page).to have_content 'いいね'
    end
    scenario '閲覧履歴タブが表示される' do
      expect(page).to have_content '閲覧履歴'
    end
    scenario 'フォローボタンが表示されない' do
      expect(page).to_not have_button 'Follow'
    end
    scenario 'フォロー中タブが表示されない' do
      expect(page).to_not have_button 'Unfollow'
    end
    scenario '会員編集ボタンが表示される' do
      expect(page).to have_link nil, href: edit_user_path(user)
    end
    scenario '会員編集ボタンを押下し、会員編集画面に遷移する' do
      click_on '編集する'
      expect(current_path).to eq edit_user_path(user)
    end
  end

  feature '会員情報編集画面のテスト' do
    background do
      visit edit_user_path(user)
    end
    scenario '会員情報が正常に更新される' do
      fill_in 'user[introduction]', with: '編集済みの自己紹介'
      click_on '変更'
      expect(page).to have_content '編集済みの自己紹介'
    end
    scenario '必須項目が空欄の場合、更新されない' do
      fill_in 'user[name]', with: ''
      click_on '変更'
      expect(page).to have_content 'を入力してください'
    end
    scenario 'ゲスト会員は、退会するを押下するとトップ画面に遷移する' do
      click_on '退会する'
      expect(current_path).to eq root_path
      expect(page).to have_content '恐れ入りますが、ゲスト会員では退会できません'
    end
  end

  feature 'ログアウトのテスト' do
    scenario '正常にログアウトされる' do
      click_on 'サインアウト'
      expect(page).to have_content 'ログアウトしました'
    end
  end
end
