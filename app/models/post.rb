class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :ingredients, dependent: :destroy
  has_many :guides, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: lambda { |attributes|
                                                                                attributes[:name].blank? && attributes[:shop_name].blank? && attributes[:price].blank?
                                                                              }
  accepts_nested_attributes_for :guides, allow_destroy: true, reject_if: lambda { |attributes|
                                                                           attributes[:guide_image].blank? && attributes[:body].blank?
                                                                         }

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

  def written_by?(target_user)
    user_id == target_user.id
  end

  def checked_commentable?
    if commentable == false
      'コメント不可'
    else
      'コメント許可'
    end
  end

  def browsing_history(user)
    new_history = histories.new
    new_history.user_id = user.id
    # 同じ投稿をcurrent_userが閲覧している場合、古い履歴を削除
    if user.histories.exists?(post_id: id)
      visited_history = user.histories.find_by(post_id: id)
      visited_history.destroy
    end
    new_history.save
  end

  def self.looks(ids)
    where('category_id LIKE?', ids.to_s)
  end

  def self.search_for(contents)
    Post.where('title LIKE?', "%#{contents}%")
  end

  def self.create_post_ranks
    Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end
end
