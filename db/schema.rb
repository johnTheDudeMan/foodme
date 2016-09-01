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

ActiveRecord::Schema.define(version: 20160823162754) do

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.string   "ingredient_type"
    t.integer  "shelf_life"
    t.string   "store_room"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "kitchen_ingredients", force: :cascade do |t|
    t.integer  "kitchen_id"
    t.integer  "ingredient_id"
    t.integer  "qty"
    t.datetime "purchase_date", default: '2016-07-22 18:27:54'
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "kitchen_ingredients", ["ingredient_id"], name: "index_kitchen_ingredients_on_ingredient_id"
  add_index "kitchen_ingredients", ["kitchen_id"], name: "index_kitchen_ingredients_on_kitchen_id"

  create_table "kitchens", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "kitchens", ["user_id"], name: "index_kitchens_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "pw_reset_digest"
    t.datetime "pw_reset_sent_at"
    t.string   "avatar"
    t.text     "blurb"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
