class Admin::ActivitiesController < ApplicationController
  before_action :authenticate_admin!

  def index
     @activities = Activity.where(activity_status: "admin_activity")
  end

  def read
    activity = Activity.find(params[:id])
    activity.read! if activity.unread?
    redirect_to activity.transition_path
  end
end
