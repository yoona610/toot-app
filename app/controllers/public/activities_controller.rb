class Public::ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cache_buster, only: %i[index]

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

  private

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
