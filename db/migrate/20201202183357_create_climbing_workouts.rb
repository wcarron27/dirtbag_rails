class CreateClimbingWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :climbing_workouts do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :user, null: false, foreign_key: true
      t.string :type
      t.string :notes
      t.integer :quality_rating

      t.timestamps
    end
  end
end
