# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_02_221429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boulder_problems", force: :cascade do |t|
    t.bigint "bouldering_workout_id", null: false
    t.integer "rpe"
    t.integer "repetitions"
    t.integer "sets"
    t.integer "rest"
    t.integer "difficulty"
    t.string "notes"
    t.boolean "sent"
    t.boolean "clean"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bouldering_workout_id"], name: "index_boulder_problems_on_bouldering_workout_id"
  end

  create_table "bouldering_workouts", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id", null: false
    t.string "location"
    t.string "notes"
    t.integer "quality_rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_bouldering_workouts_on_user_id"
  end

  create_table "climbing_routes", force: :cascade do |t|
    t.bigint "climbing_workout_id", null: false
    t.integer "rpe"
    t.integer "repetitions"
    t.integer "sets"
    t.integer "rest"
    t.integer "difficulty"
    t.string "notes"
    t.boolean "sent"
    t.boolean "clean"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["climbing_workout_id"], name: "index_climbing_routes_on_climbing_workout_id"
  end

  create_table "climbing_workouts", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id", null: false
    t.string "type"
    t.string "notes"
    t.integer "quality_rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "location"
    t.index ["user_id"], name: "index_climbing_workouts_on_user_id"
  end

  create_table "hangboard_workouts", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id", null: false
    t.string "location"
    t.string "type"
    t.string "notes"
    t.integer "quality_rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_hangboard_workouts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.string "gender"
    t.boolean "tos"
    t.date "birthday"
  end

  add_foreign_key "boulder_problems", "bouldering_workouts"
  add_foreign_key "bouldering_workouts", "users"
  add_foreign_key "climbing_routes", "climbing_workouts"
  add_foreign_key "climbing_workouts", "users"
  add_foreign_key "hangboard_workouts", "users"
end
