class Activity < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  belongs_to :subject, polymorphic: true

  include Rails.application.routes.url_helpers

  enum action_type: { commented_to_own_post: 0, liked_to_own_post: 1, followed_me: 2 }
  enum read: { unread: false, read: true }

  def transition_path
    case action_type.to_sym
    when :commented_to_own_post
      post_path(subject.post)
    when :liked_to_own_post
      post_path(subject.post)
    when :followed_me
      user_path(subject.follower)
    end
  end
end
