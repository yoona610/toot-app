class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :activity, as: :subject, dependent: :destroy

  after_create_commit :create_activities

  private

  def create_activities
    Activity.create!(subject: self, user: self.post.user, action_type: :liked_to_own_post)
  end
end
