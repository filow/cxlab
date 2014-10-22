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

ActiveRecord::Schema.define(version: 20141016133926) do

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

  add_index "admins", ["uid"], name: "index_admins_on_uid", unique: true, using: :btree

  create_table "admins_roles", id: false, force: true do |t|
    t.integer "admin_id", null: false
    t.integer "role_id",  null: false
  end

  add_index "admins_roles", ["admin_id", "role_id"], name: "index_admins_roles_on_admin_id_and_role_id", using: :btree

  create_table "config_types", force: true do |t|
    t.string  "name"
    t.boolean "edit_flag", default: false
  end

  create_table "configs", force: true do |t|
    t.string  "key"
    t.text    "value"
    t.integer "config_type_id"
    t.string  "field_type"
    t.boolean "edit_flag",      default: false
  end

  add_index "configs", ["config_type_id"], name: "index_configs_on_config_type_id", using: :btree
  add_index "configs", ["key"], name: "index_configs_on_key", unique: true, using: :btree

  create_table "nodes", force: true do |t|
    t.string  "name",      limit: 30,                 null: false
    t.string  "title",                                null: false
    t.string  "remark"
    t.integer "sort",                 default: 0
    t.integer "pid",                  default: 0
    t.boolean "edit_flag",            default: false
  end

  add_index "nodes", ["name"], name: "index_nodes_on_name", unique: true, using: :btree
  add_index "nodes", ["sort"], name: "index_nodes_on_sort", using: :btree

  create_table "nodes_roles", id: false, force: true do |t|
    t.integer "role_id", null: false
    t.integer "node_id", null: false
  end

  add_index "nodes_roles", ["role_id", "node_id"], name: "index_nodes_roles_on_role_id_and_node_id", using: :btree

  create_table "professions", force: true do |t|
    t.string  "name"
    t.integer "pid",  default: 0
  end

  create_table "roles", force: true do |t|
    t.string  "name",                      null: false
    t.boolean "is_enabled", default: true
    t.string  "remark"
  end

  create_table "students", force: true do |t|
    t.string   "stuid",            limit: 20
    t.string   "name",                                        null: false
    t.string   "password",         limit: 64,                 null: false
    t.string   "email"
    t.string   "phone"
    t.integer  "profession_id"
    t.integer  "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_email_checked",            default: false
    t.boolean  "is_phone_checked",            default: false
    t.string   "avatar"
  end

  add_index "students", ["name"], name: "index_students_on_name", using: :btree
  add_index "students", ["stuid"], name: "index_students_on_stuid", unique: true, using: :btree

end
