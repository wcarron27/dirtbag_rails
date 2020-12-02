class AddLocationToClimbingWorkouts < ActiveRecord::Migration[6.0]
  def change
    add_column :climbing_workouts, :location, :string
  end
end
