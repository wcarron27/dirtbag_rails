class CreateClimbingRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :climbing_routes do |t|
      t.references :climbing_workout, null: false, foreign_key: true
      t.integer :rpe
      t.integer :repetitions
      t.integer :sets
      t.integer :rest
      t.integer :difficulty
      t.string :notes
      t.boolean :sent
      t.boolean :clean

      t.timestamps
    end
  end
end
