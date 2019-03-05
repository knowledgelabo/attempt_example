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

ActiveRecord::Schema.define(version: 2019_03_05_084853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "divisions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fiscal_years", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.bigint "division_id", null: false
    t.string "full_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_members_on_division_id"
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "fiscal_year_id", null: false
    t.bigint "member_id", null: false
    t.integer "amount", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fiscal_year_id"], name: "index_sales_on_fiscal_year_id"
    t.index ["member_id"], name: "index_sales_on_member_id"
  end

  add_foreign_key "members", "divisions"
  add_foreign_key "sales", "fiscal_years"
  add_foreign_key "sales", "members"
end
