require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # factoriesで作成したダミーデータを使用します。
    let(:user) { FactoryBot.create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    # test_postを作成し、空欄での登録ができるか確認します。
    subject { test_post.valid? }
    let(:test_post) { post }


    context 'titleカラム' do
      it '空欄でないこと' do
        test_post.title = ''
        is_expected.to eq false;
      end
      it '20文字以下であること' do
        post.title = Faker::Lorem.characters(number:21)
        expect(post.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
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