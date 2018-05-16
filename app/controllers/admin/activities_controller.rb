class Admin::ActivitiesController < AdminController
  before_action [:index, :new, :last_month, :accompaniments, :last_month_accompaniments], :active_for_community?

  def index
    @activities = Activity.current_month(events: Activity::NON_ACCOMPANIMENT_ELIGIBLE_EVENTS)
  end

  def last_month
    @activities = Activity.last_month(events: Activity::NON_ACCOMPANIMENT_ELIGIBLE_EVENTS)
  end

  def accompaniments
    @activities = Activity.current_month(events: Activity::ACCOMPANIMENT_ELIGIBLE_EVENTS)
  end

  def last_month_accompaniments
    @activities = Activity.last_month(events: Activity::ACCOMPANIMENT_ELIGIBLE_EVENTS)
  end

  def new
    @activity = Activity.new
  end

  def edit
    @activity = activity
  end

  def create
    @activity = Activity.new(activity_params)
    if activity.save
      flash[:success] = 'Activity saved.'
      redirect_to admin_activities_path
    else
      flash.now[:error] = 'Activity not saved.'
      render :new
    end
  end

  def update
    if activity.update(activity_params)
      flash[:success] = 'Activity saved.'
      redirect_to admin_activities_path
    else
      flash.now[:error] = 'Activity not saved.'
      render :edit
    end
  end

  def activity
    @activity ||= Activity.find(params[:id])
  end

  private
  def activity_params
    params.require(:activity).permit(
      :event,
      :location_id,
      :friend_id,
      :judge_id,
      :occur_at,
      :notes
    )
  end

  def active_for_community?
  end
end