class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :activity, as: :subject, dependent: :destroy

  after_create_commit :create_activities

  private

  def create_activities
    Activity.create!(subject: self, user: self.post.user, action_type: :bookmarked_to_own_post, activity_status: :user_activity)
  end
end
