# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180409204904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.date "date"
    t.string "status"
    t.integer "student_id"
    t.integer "user_id"
    t.integer "time_slot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.boolean "high_school"
    t.integer "account_id"
    t.boolean "active?"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "birthday"
  end

  create_table "time_slots", force: :cascade do |t|
    t.string "day"
    t.string "time"
    t.integer "capacity"
    t.boolean "high_school_only"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.integer "account_id"
    t.string "relationship"
    t.string "phone_number"
    t.boolean "active?"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
