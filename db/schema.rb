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

ActiveRecord::Schema.define(version: 20151001000022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brokers", force: :cascade do |t|
    t.string   "name"
    t.jsonb    "fields",     default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "brokers", ["fields"], name: "index_brokers_on_fields", using: :gin

  create_table "codings", force: :cascade do |t|
    t.jsonb    "properties", default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "codings", ["properties"], name: "index_codings_on_properties", using: :gin

  create_table "coefficients", force: :cascade do |t|
    t.float    "intercept"
    t.jsonb    "coefficients",        default: {}, null: false
    t.integer  "product_template_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "coefficients", ["coefficients"], name: "index_coefficients_on_coefficients", using: :gin
  add_index "coefficients", ["product_template_id"], name: "index_coefficients_on_product_template_id", using: :btree

  create_table "competitors", force: :cascade do |t|
    t.integer  "tariff_id"
    t.string   "name"
    t.float    "premium"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "competitors", ["tariff_id"], name: "index_competitors_on_tariff_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "insurers", force: :cascade do |t|
    t.string   "name"
    t.string   "timezone"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_templates", force: :cascade do |t|
    t.string   "name"
    t.string   "tag"
    t.jsonb    "properties", default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "product_templates", ["properties"], name: "index_product_templates_on_properties", using: :gin

  create_table "products", force: :cascade do |t|
    t.integer  "product_template_id"
    t.integer  "tariff_id"
    t.string   "name"
    t.string   "brand"
    t.jsonb    "properties",          default: {}, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "products", ["product_template_id"], name: "index_products_on_product_template_id", using: :btree
  add_index "products", ["properties"], name: "index_products_on_properties", using: :gin
  add_index "products", ["tariff_id"], name: "index_products_on_tariff_id", using: :btree

  create_table "risks", force: :cascade do |t|
    t.integer  "tariff_id"
    t.integer  "exposition"
    t.integer  "frequency"
    t.integer  "risk"
    t.float    "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "risks", ["tariff_id"], name: "index_risks_on_tariff_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "product_name"
    t.integer  "answer"
    t.integer  "product_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "surveys", ["product_id"], name: "index_surveys_on_product_id", using: :btree

  create_table "tariffs", force: :cascade do |t|
    t.integer  "insurer_id"
    t.jsonb    "properties", default: {}, null: false
    t.integer  "segment",    default: 1,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "tariffs", ["insurer_id"], name: "index_tariffs_on_insurer_id", using: :btree
  add_index "tariffs", ["properties"], name: "index_tariffs_on_properties", using: :gin

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "admin",                  default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "utilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "products", "product_templates"
end
