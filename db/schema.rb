# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_26_204350) do

  create_table "ashes", force: :cascade do |t|
    t.integer "value", null: false
    t.string "source", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "consumptions", force: :cascade do |t|
    t.integer "value", null: false
    t.string "source", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "storages", force: :cascade do |t|
    t.integer "value", null: false
    t.string "source", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "weathers", force: :cascade do |t|
    t.integer "consumption_id"
    t.decimal "temp", precision: 10, scale: 2
    t.decimal "feels_like", precision: 10, scale: 2
    t.decimal "temp_min", precision: 10, scale: 2
    t.decimal "temp_max", precision: 10, scale: 2
    t.decimal "humidity", precision: 10, scale: 2
    t.decimal "pressure", precision: 10, scale: 2
    t.decimal "wind_speed", precision: 10, scale: 2
    t.decimal "wind_deg", precision: 10, scale: 2
    t.decimal "wind_gust", precision: 10, scale: 2
    t.integer "code"
    t.string "main"
    t.string "description"
    t.string "icon"
    t.integer "visibility"
    t.integer "clouds"
    t.datetime "weather_timestamp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["consumption_id"], name: "index_weathers_on_consumption_id"
  end

end
