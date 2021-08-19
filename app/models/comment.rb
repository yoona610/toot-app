class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :activity, as: :subject, dependent: :destroy

  attribute :current_user
  after_create_commit :create_activities

  private

  def create_activities
    unless self.post.user_id == current_user
      Activity.create!(subject: self, user: self.post.user, action_type: :commented_to_own_post, activity_status: :user_activity)
    end
  end
end