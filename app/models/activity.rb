class Activity < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  belongs_to :subject, polymorphic: true

  include Rails.application.routes.url_helpers

  enum action_type: { commented_to_own_post: 0, liked_to_own_post: 1, bookmarked_to_own_post: 2, followed_me: 3,
                      chated_me: 4, chated_admin: 5, chatroom_admin: 6 }
  enum activity_status: { user_activity: false, admin_activity: true }
  enum read: { unread: false, read: true }

  def transition_path
    case action_type.to_sym
    when :commented_to_own_post
      post_path(subject.post)
    when :liked_to_own_post
      post_path(subject.post)
    when :bookmarked_to_own_post
      post_path(subject.post)
    when :followed_me
      user_path(subject.follower)
    when :chated_me
      chats_path(subject.chat_room)
    end
  end

  def redirect_path
    case action_type.to_sym
    when :chated_admin
      admin_chat_path(subject.chat_room)
    when :chatroom_admin
      admin_chat_path(subject)
    end
  end

  def self.unread_count(user)
    Activity.where(user_id: user.id, activity_status: 'user_activity', read: 'unread').count
  end
end
