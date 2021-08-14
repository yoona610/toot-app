class Public::ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = Activity.where(user_id: current_user.id)
  end

  def read
    activity = Activity.find(params[:id])
    activity.read! if activity.unread?
    redirect_to activity.transition_path
  end
end
