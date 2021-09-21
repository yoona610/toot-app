class Admin::ActivitiesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_cache_buster, only: %i[index]

  def index
    @activities = Activity.includes(subject: :user).where(activity_status: 'admin_activity').order(created_at: 'DESC').page(params[:page]).per(20)
    @admin_activities_count = Activity.includes(:subject).where(activity_status: 'admin_activity', read: 'unread').count
  end

  def read
    activity = Activity.includes(:subject).find(params[:id])
    activity.read! if activity.unread?
    redirect_to activity.redirect_path
  end

  private

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
