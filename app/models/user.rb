class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :introduction, length: { maximum: 40 }
  with_options presence: true do
    validates :name
    validates :email
  end

  attachment :profile_image

  def is_deleted_status
    if is_deleted == true
      "退会済"
    elsif is_deleted == false
      "有効"
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト会員"
      user.introduction = "ゲスト・アカウント（会員）です。"
      user.id = 2
    end
  end
end
