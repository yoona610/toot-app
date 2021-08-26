class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy

  after_update_commit :update_activities

  def response_status_sring
    if response_status == true
      "解決済み"
    elsif response_status == false
      "未解決"
    end
  end

  private

  def update_activities
    if response_status == true
      Activity.create!(subject: self, user: self.user, action_type: :chatroom_admin, activity_status: :admin_activity)
    end
  end
end