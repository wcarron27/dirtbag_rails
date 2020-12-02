class BoulderingWorkoutsController < ApplicationController
  before_action :authenticate_user
  before_action :set_workout_or_exit, only: [:show, :update, :destroy]

  def index
    @bouldering_workouts = BoulderingWorkout.where(user_id: @user.id)
    if @bouldering_workouts.nil? || @bouldering_workouts.blank?
      render json: { message: 'Bouldering workouts not found' }, status: 404
    else
      render json: { bouldering_workouts: @bouldering_workouts }, status: 200
    end
  end

  def create
    @bouldering_workout = BoulderingWorkout.create(create_params)
    @bouldering_workout.user_id = @user.id

    if @bouldering_workout.valid? && @bouldering_workout.save
      render json: { message: 'Bouldering workout created', bouldering_workout: @bouldering_workout }, status: 200
    else
      render json: { message: @bouldering_workout.errors }, status: 500
    end
  end

  def show
    authorize_action(@bouldering_workout)
    render json: { bouldering_workout: @bouldering_workout }, status: 200
  end

  def update
    authorize_action(@bouldering_workout)
    if @bouldering_workout.update(update_params)
      render json: { message: 'Bouldering workout updated' }, status: 200
    else
      render json: { message: @bouldering_workout.errors }, status: 500
    end
  end

  def destroy
    authorize_action(@bouldering_workout)
    if @bouldering_workout.destroy
      render json: { message: 'Bouldering workout deleted' }, status: 200
    else
      render json: { message: @bouldering_workout.errors }, status: 500
    end
  end

  private

  def create_params
    params.require(:workout).permit(:location, :start_time, :end_time, :user_id, :notes, :quality_rating)
  end


  def update_params
    params.require(:workout).permit(:location, :start_time, :end_time, :notes, :quality_rating)
  end

  def set_workout_or_exit
    @bouldering_workout = BoulderingWorkout.find_by(id: params[:id])

    if @bouldering_workout.nil? || @bouldering_workout.blank?
      render json: { message: 'Bouldering workout not found' }, status: 404
    end
  end
end
