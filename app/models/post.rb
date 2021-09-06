class Post < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: lambda { |attributes|
                                                                                attributes[:name].blank? && attributes[:shop_name].blank? && attributes[:price].blank?
                                                                              }

  mount_uploader :post_image, PostUploader

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

  def written_by?(current_user)
    user_id == current_user.id
  end

  def checked_commentable?
    if commentable == false
      'コメント不可'
    else
      'コメント許可'
    end
  end

  def self.search_for(contents)
    Post.where('title LIKE?', "%#{contents}%")
  end

  def self.create_post_ranks
    Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end
end
