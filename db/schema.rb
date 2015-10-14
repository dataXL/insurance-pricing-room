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

ActiveRecord::Schema.define(version: 20151203131264) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "tablefunc"

  create_table "products", force: :cascade do |t|
    t.string "company"
    t.jsonb  "properties", default: {}, null: false
    t.float  "premium"
  end

  add_index "products", ["properties"], name: "index_products_on_properties", using: :gin

  create_table "profiles", force: :cascade do |t|
  end

  create_table "risks", force: :cascade do |t|
    t.jsonb   "covariates", default: {}, null: false
    t.integer "exposition"
    t.integer "frequency"
    t.integer "risk"
    t.float   "cost"
  end

  add_index "risks", ["covariates"], name: "index_risks_on_covariates", using: :gin

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "timezone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_digest"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "activation_digest"
    t.boolean  "activated",           default: false
    t.datetime "activated_at"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
