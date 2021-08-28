class Public::ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = Activity.includes(:subject).where(user_id: current_user.id,
                                                    activity_status: 'user_activity').order(created_at: 'DESC').page(params[:page]).per(20)
    @activities_count = Activity.includes(:subject).where(user_id: current_user.id, activity_status: 'user_activity',
                                                          read: 'unread').count
  end

  def read
    activity = Activity.includes(:subject).find(params[:id])
    activity.read! if activity.unread?
    redirect_to activity.transition_path
  end
end
