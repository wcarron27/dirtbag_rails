class CreateBoulderProblems < ActiveRecord::Migration[6.0]
  def change
    create_table :boulder_problems do |t|
      t.references :bouldering_workout, null: false, foreign_key: true
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
