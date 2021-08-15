class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create_commit :create_activities

  private

  def create_activities
    Activity.create!(subject: self, user: self.post.user, action_type: :bookmarked_to_own_post)
  end
end
