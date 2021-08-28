class Admin::ActivitiesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @activities = Activity.includes(subject: :user).where(activity_status: 'admin_activity').order(created_at: 'DESC').page(params[:page]).per(20)
    @admin_activities_count = Activity.includes(:subject).where(activity_status: 'admin_activity', read: 'unread').count

  end

  def read
    activity = Activity.includes(:subject).find(params[:id])
    activity.read! if activity.unread?
    if activity.action_type == 'chatroom_admin'
      redirect_to activity.redirect_path
    else
      redirect_to activity.transition_path
    end
  end
end
