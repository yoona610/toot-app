class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy

  after_update_commit :update_activities

  private

  def update_activities
    if response_status == true
      Activity.create!(subject: self, user: self.user, action_type: :chatroom_admin, activity_status: :admin_activity)
    end
  end
end