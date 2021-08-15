class Chat < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  belongs_to :chat_room
  has_one :activity, as: :subject, dependent: :destroy

  after_create_commit :create_activities

  private

  def create_activities
    Activity.create!(subject: self, user: self.chat_room.user, action_type: :chated_me)
  end
end
