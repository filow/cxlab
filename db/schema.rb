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

ActiveRecord::Schema.define(version: 20140927033007) do

  create_table "admins", force: true do |t|
    t.string   "uid",                                  null: false
    t.string   "nickname",                             null: false
    t.string   "password",   limit: 64,                null: false
    t.string   "email"
    t.text     "desc"
    t.boolean  "is_enabled",            default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins_roles", id: false, force: true do |t|
    t.integer "admin_id", null: false
    t.integer "role_id",  null: false
  end

  add_index "admins_roles", ["admin_id", "role_id"], name: "index_admins_roles_on_admin_id_and_role_id", using: :btree

  create_table "config_types", force: true do |t|
    t.string "name"
  end

  create_table "configs", force: true do |t|
    t.string  "key"
    t.text    "value"
    t.integer "config_type_id"
    t.string  "field_type"
  end

  create_table "roles", force: true do |t|
    t.string  "name",                      null: false
    t.boolean "is_enabled", default: true
    t.string  "remark"
  end

end
