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

ActiveRecord::Schema[8.0].define(version: 2025_04_16_060109) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "leaders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "brand", null: false
    t.decimal "leader_rating", null: false
    t.integer "length", null: false
    t.integer "material", null: false
    t.integer "price", default: 0
    t.date "purchase_date", default: -> { "CURRENT_DATE" }, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leaders_on_user_id"
  end

  create_table "lines", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "brand", null: false
    t.decimal "pe_rating", null: false
    t.integer "length", null: false
    t.integer "strand_count", null: false
    t.boolean "marker", default: true, null: false
    t.integer "price", default: 0
    t.date "purchase_date", default: -> { "CURRENT_DATE" }, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lines_on_user_id"
  end

  create_table "reels", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "brand", null: false
    t.integer "reel_type", null: false
    t.integer "gear_type", null: false
    t.bigint "line_id", null: false
    t.integer "price", default: 0, null: false
    t.date "purchase_date", default: -> { "CURRENT_DATE" }, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_id"], name: "index_reels_on_line_id"
    t.index ["user_id"], name: "index_reels_on_user_id"
  end

  create_table "rods", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.integer "length"
    t.integer "fishing_type"
    t.integer "power"
    t.integer "reel_type"
    t.integer "min_weight"
    t.integer "max_weight"
    t.date "purchase_date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "price", default: 0
    t.index ["user_id"], name: "index_rods_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tackles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.bigint "rod_id", null: false
    t.bigint "reel_id", null: false
    t.integer "knot", null: false
    t.bigint "leader_id", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leader_id"], name: "index_tackles_on_leader_id"
    t.index ["reel_id"], name: "index_tackles_on_reel_id"
    t.index ["rod_id"], name: "index_tackles_on_rod_id"
    t.index ["user_id"], name: "index_tackles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false, null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "leaders", "users"
  add_foreign_key "lines", "users"
  add_foreign_key "reels", "lines"
  add_foreign_key "reels", "users"
  add_foreign_key "rods", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "tackles", "leaders"
  add_foreign_key "tackles", "reels"
  add_foreign_key "tackles", "rods"
  add_foreign_key "tackles", "users"
end
