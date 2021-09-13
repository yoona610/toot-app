require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { create(:user) }
  let!(:post) { FactoryBot.create(:post) }

  describe 'Postモデルのメソッドのテスト' do
    it "いいねしていない場合、liked_by?メソッドでFALSEが返る" do
      expect(post.liked_by?(user)).to eq false
    end
    it "ブックマークしていない場合、saved_by?メソッドでFALSEが返る" do
      expect(post.bookmarked_by?(user)).to eq false
    end
  end
end