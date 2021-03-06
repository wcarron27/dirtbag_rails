class CreateBoulderingWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :bouldering_workouts do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.string :notes
      t.integer :quality_rating

      t.timestamps
    end
  end
end
