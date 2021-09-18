require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:post) { FactoryBot.create(:post) }

  describe 'コメントのバリデーション・テスト' do
    it '35文字以内の場合、コメント投稿に成功する' do
      comment = Comment.new(comment: Faker::Lorem.characters(number: 35))
      comment.post_id = post.id
      comment.user_id = post.user.id
      expect(comment).to be_valid
    end
    it '36文字以上の場合、コメント投稿に失敗する' do
      comment = Comment.new(comment: Faker::Lorem.characters(number: 36))
      comment.post_id = post.id
      comment.user_id = post.user.id
      expect(comment).not_to be_valid
    end
    it '空欄場合、コメント投稿に失敗する' do
      comment = Comment.new(comment: Faker::Lorem.characters(number: 0))
      expect(comment).not_to be_valid
    end
  end
  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'postモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    # has_manyの関係性で記述するのもありです。
    # context 'PostCommentモデルとの関係' do
    # it '1:Nとなっている' do
    # expect(Post.reflect_on_association(:post_comments).macro).to eq :has_many
    # end
    # end
  end
end
