# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151027210738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.integer  "total"
    t.integer  "trip_id"
    t.string   "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "trip_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "date"
  end

  create_table "trips", force: :cascade do |t|
    t.string   "destination"
    t.string   "start_date"
    t.string   "end_date"
    t.string   "image_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "trips_wardrobes", id: false, force: :cascade do |t|
    t.integer "trip_id",     null: false
    t.integer "wardrobe_id", null: false
  end

  add_index "trips_wardrobes", ["trip_id", "wardrobe_id"], name: "index_trips_wardrobes_on_trip_id_and_wardrobe_id", using: :btree
  add_index "trips_wardrobes", ["wardrobe_id", "trip_id"], name: "index_trips_wardrobes_on_wardrobe_id_and_trip_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "uid"
  end

  create_table "wardrobes", force: :cascade do |t|
    t.string   "name"
    t.integer  "quantity"
    t.boolean  "reminder"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "date"
    t.integer  "trip_id"
  end

end
