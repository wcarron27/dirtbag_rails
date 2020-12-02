class ClimbingWorkoutsController < ApplicationController
  before_action :authenticate_user
  before_action :set_workout_or_exit, only: [:show, :update, :destroy]

  def index
    @climbing_workouts = ClimbingWorkout.where(user_id: @user.id)
    if @climbing_workouts.nil? || @climbing_workouts.blank?
      render json: { message: 'Climbing workouts not found' }, status: 404
    elsif @climbing_workouts.length >= 1
      render json: { climbing_workouts: @climbing_workouts }, status: 200
    end
  end

  def create
    @climbing_workout = ClimbingWorkout.create(create_params)
    @climbing_workout.user_id = @user.id

    if @climbing_workout.valid? && @climbing_workout.save
      render json: { message: 'Climbing workout created', climbing_workout: @climbing_workout }, status: 200
    else
      render json: { message: @climbing_workout.errors }, status: 500
    end
  end

  def show
    authorize_action(@climbing_workout)
    render json: { climbing_workout: @climbing_workout}, status: 200
  end

  def update
    authorize_action(@climbing_workout)
    if @climbing_workout.update(update_params)
      render json: { message: 'Climbing workout updated', climbing_workout: @climbing_workout }, status: 200
    else
      render json: { message: @climbing_workout.errors }, status: 500
    end
  end

  def destroy
    authorize_action(@climbing_workout)
    if @climbing_workout.destroy
      render json: { message: 'Climbing workout deleted' }, status: 200
    else
      render json: { message: @climbing_workout.errors }, status: 500
    end
  end

  private

  def create_params
    params.require(:workout).permit(:start_time, :end_time, :user_id, :location, :notes, :quality_rating, :type)
  end

  def update_params
    params.require(:workout).permit(:start_time, :end_time, :notes, :location, :quality_rating, :location)
  end

  def set_workout_or_exit
    @climbing_workout = ClimbingWorkout.find_by(id: params[:id])

    if @climbing_workout.nil? || @climbing_workout.blank?
      render json: { message: 'Climbing workout not found' }, status: 404
    end
  end
end
