class Post < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: lambda {|attributes| attributes[:name].blank?}
  attachment :post_image

  with_options presence: true, on: :publicize do
    validates :title
    validates :post_image
    validates :introduction
  end
    validates :title, length: { maximum: 14 }, on: :publicize
    validates :introduction, length: { maximum: 80 }, on: :publicize

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  def commentable_status
    if commentable == false
      "コメント不可"
    elsif commentable == true
      "コメント許可"
    end
  end
end