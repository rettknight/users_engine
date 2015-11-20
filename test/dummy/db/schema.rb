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

ActiveRecord::Schema.define(version: 20151113154807) do

  create_table "users_relationships", force: :cascade do |t|
    t.integer  "owner_id",   limit: 4
    t.integer  "contact_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "users_relationships", ["owner_id"], name: "index_relationships_on_owner_id"

  create_table "users_tests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_users", force: :cascade do |t|
    t.integer  "active",               limit: 4,   default: 1, null: false
    t.string   "name",                 limit: 100,             null: false
    t.string   "lastname",             limit: 100
    t.string   "email",                limit: 100,             null: false
    t.string   "encrypted_password",   limit: 255
    t.string   "salt",                 limit: 200
    t.datetime "updatedAt"
    t.datetime "createdAt"
    t.datetime "deletedAt"
    t.datetime "lastConnection"
    t.string   "rfc",                  limit: 255
    t.string   "curp",                 limit: 255
    t.integer  "userType_id",          limit: 4
    t.datetime "time_requested"
    t.string   "password_reset_token", limit: 255
  end

  add_index "users_users", ["userType_id"], name: "index_userTypes_on_userType_id"

  create_table "users_usertypes", force: :cascade do |t|
    t.string "name", limit: 255
  end

end
