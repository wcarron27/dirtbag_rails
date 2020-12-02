class BoulderingWorkoutsController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_user, only: [:update, :destroy]

  def create
    @bouldering_workout = BoulderingWorkout.create(create_params)
    @bouldering_workout.user_id = @user.id

    if @bouldering_workout.valid? && @bouldering_workout.save
      render json: { bouldering_workout: @bouldering_workout }, status: 200
    else
      render json: { message: @bouldering_workout.errors }, status: 400
    end
  end

  def index
    @bouldering_workouts = BoulderingWorkout.where(user_id: @user.id)
    if @bouldering_workouts.blank?
      render json: { message: 'No bouldering workouts'}, status: 204
    else
      render json: { bouldering_workouts: @bouldering_workouts }, status: 200
    end
  end

  def show
    @bouldering_workout = BoulderingWorkout.find_by(id: params[:id])

    if @bouldering_workout.nil?
      render json: { message: 'No bouldering workout'}, status: 404
    else
      render json: { bouldering_workout: @bouldering_workout }, status: 200
    end
  end

  def update
    @bouldering_workout = BoulderingWorkout.find_by(id: params[:id])

    if @bouldering_workout.update(update_params)
      render json: { message: 'Bouldering workout updated' }, status: 204
    else
      render json: { message: @bouldering_workout.errors }, status: 500
    end
  end

  def destroy
    @bouldering_workout = BoulderingWorkout.find_by(id: params[:id])

    if @bouldering_workout.nil?
      render json: { message: 'Bouldering workout not found' }, status: 404
    elsif @bouldering_workout.destroy
      render json: { message: 'Bouldering workout deleted' }, status: 204
    else
      render json: { message: 'Unable to delete workout' }, status: 500
    end
  end

  private

  def update_params
    params.require(:workout).permit(:location, :start_time, :end_time, :notes, :quality_rating)
  end

  def create_params
    params.require(:workout).permit(:location, :start_time, :end_time, :user_id, :notes, :quality_rating)
  end
end
