class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  has_many :posts, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_one :chat_room, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :activities, as: :subject, dependent: :destroy

  validates :introduction, length: { maximum: 40 }
  with_options presence: true do
    validates :name
    validates :email
  end

  attachment :profile_image

  def deleted_status
    if is_deleted == true
      '退会済'
    else
      '有効'
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲスト会員'
      user.introduction = 'ゲスト・アカウント（会員）です。'
      user.id = 1
    end
  end

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  # ユーザーの検索
  def self.search_for(contents)
    User.where('name LIKE?', "%#{contents}%")
  end

  # いいねの削除
  def destroy_like(post)
    likes.find_by(post_id: post.id).destroy
  end

  def checked_user?(current_user)
    id == current_user.id
  end
end
