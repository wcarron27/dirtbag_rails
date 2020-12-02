class HangboardWorkoutsController < ApplicationController
  before_action :authenticate_user
  before_action :set_workout_or_exit, only: [:show, :update, :destroy]

  def index
    @hangboard_workouts = HangboardWorkout.where(user_id: @user.id)
    if @hangboard_workouts.nil? || @hangboard_workouts.blank?
      render json: { message: 'Climbing workouts not found' }, status: 404
    elsif @hangboard_workouts.length >= 1
      render json: { climbing_workouts: @hangboard_workouts }, status: 200
    end
  end

  def create
    @hangboard_workout = HangboardWorkout.create(create_params)
    @hangboard_workout.user_id = @user.id

    if @hangboard_workout.valid? && hangboard_workout.save
      render json: { message: 'Hangboard workout created', hangboard_workout: @hangboard_workout }, status: 200
    else
      render json: { message: @hangboard_workout.errors }, status: 500
    end
  end

  def show
    authorize_action(@hangboard_workout)
    render json: { hangboard_workout: @hangboard_workout }, status: 200
  end

  def update
    authorize_action(@hangboard_workout)
    if @hangboard_workout.update(update_params)
      render json: { message: 'Hangboard workout updated', hangboard_workout: @hangboard_workout }, status: 200
    else
      render json: { message: @hangboard_workout.errors }, status: 500
    end
  end

  def destroy
    authorize_action(@hangboard_workout)
    if @hangboard_workout.destroy
      render json: { message: 'Hangboard workout deleted' }, status: 200
    else
      render json: { message: @hangboard_workout.errors }, status: 500
    end
  end

  private

  def create_params
    params.require(:workout).permit(:start_time, :end_time, :location, :user_id, :notes, :quality_rating)
  end

  def update_params
    params.require(:workout).permit(:start_time, :end_time, :location, :notes, :quality_rating)
  end

  def set_workout_or_exit
    @hangboard_workout = HangboardWorkout.find_by(id: params[:id])

    if @hangboard_workout.nil? || @hangboard_workout.blank?
      render json: { message: 'Hangboard workout not found' }, status: 404
    end
  end
end
