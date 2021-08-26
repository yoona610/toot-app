class Chat < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  belongs_to :chat_room
  has_one :activity, as: :subject, dependent: :destroy

  validates :message, presence: true, length: { maximum: 60 }

  after_create_commit :create_activities

  private

  def create_activities
    if is_admin == true
      Activity.create!(subject: self, user: self.chat_room.user, action_type: :chated_me, activity_status: :user_activity)
    else
      Activity.create!(subject: self, user: self.chat_room.user, action_type: :chated_admin, activity_status: :admin_activity)
    end
  end
end
