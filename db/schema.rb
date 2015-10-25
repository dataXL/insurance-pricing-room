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

ActiveRecord::Schema.define(version: 20151213131279) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "tablefunc"

  create_table "codings", force: :cascade do |t|
    t.jsonb "properties", default: {}, null: false
  end

  add_index "codings", ["properties"], name: "index_codings_on_properties", using: :gin

  create_table "competitors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.float    "premium"
    t.integer  "tariff_id"
  end

  add_index "competitors", ["tariff_id"], name: "index_competitors_on_tariff_id", using: :btree

  create_table "insurers", force: :cascade do |t|
    t.string   "name"
    t.string   "timezone"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string  "insurer"
    t.float   "premium"
    t.integer "tariff_id"
  end

  add_index "products", ["tariff_id"], name: "index_products_on_tariff_id", using: :btree

  create_table "risks", force: :cascade do |t|
    t.integer "exposition"
    t.integer "frequency"
    t.integer "risk"
    t.float   "cost"
    t.integer "tariff_id"
  end

  add_index "risks", ["tariff_id"], name: "index_risks_on_user_id", using: :btree

  create_table "tariffs", force: :cascade do |t|
    t.jsonb    "properties", default: {}, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "premium"
    t.integer  "segment",    default: 1
    t.integer  "insurer_id"
  end

  add_index "tariffs", ["insurer_id"], name: "index_tariffs_on_insurer_id", using: :btree
  add_index "tariffs", ["properties"], name: "index_tariffs_on_properties", using: :gin

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.boolean  "admin",             default: false
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "insurer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["insurer_id"], name: "index_users_on_insurer_id", using: :btree

  create_table "utilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
