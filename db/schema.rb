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

ActiveRecord::Schema.define(version: 20141128122216) do

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

  create_table "competes", force: true do |t|
    t.date    "start_time",                 null: false
    t.date    "end_time",                   null: false
    t.integer "admin_id",                   null: false
    t.integer "contest_id",                 null: false
    t.boolean "is_deleted", default: false
  end

  add_index "competes", ["contest_id"], name: "competes_contest_id_fk", using: :btree
  add_index "competes", ["end_time"], name: "index_competes_on_end_time", using: :btree
  add_index "competes", ["start_time"], name: "index_competes_on_start_time", using: :btree

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
    t.text    "description"
    t.string  "name"
  end

  add_index "configs", ["config_type_id"], name: "index_configs_on_config_type_id", using: :btree
  add_index "configs", ["key"], name: "index_configs_on_key", unique: true, using: :btree

  create_table "contests", force: true do |t|
    t.string   "name",                        null: false
    t.text     "description"
    t.string   "level"
    t.string   "organizer"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "summary"
    t.string   "fullname"
    t.string   "website_url"
    t.boolean  "is_deleted",  default: false
  end

  add_index "contests", ["is_deleted"], name: "index_contests_on_is_deleted", using: :btree

  create_table "news", force: true do |t|
    t.string   "title",                        null: false
    t.string   "author"
    t.text     "content"
    t.text     "pure_content"
    t.boolean  "is_draft",     default: true
    t.boolean  "is_deleted",   default: false
    t.datetime "publish_at"
    t.integer  "contest_id"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "summary"
  end

  add_index "news", ["contest_id"], name: "index_news_on_contest_id", using: :btree
  add_index "news", ["is_deleted"], name: "index_news_on_is_deleted", using: :btree
  add_index "news", ["is_draft"], name: "index_news_on_is_draft", using: :btree
  add_index "news", ["publish_at"], name: "index_news_on_publish_at", using: :btree

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

  add_index "professions", ["pid"], name: "index_professions_on_pid", using: :btree

  create_table "roles", force: true do |t|
    t.string  "name",                      null: false
    t.boolean "is_enabled", default: true
    t.string  "remark"
  end

  create_table "sections", force: true do |t|
    t.string   "name",       null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "compete_id"
  end

  add_index "sections", ["compete_id"], name: "sections_compete_id_fk", using: :btree
  add_index "sections", ["end_time"], name: "index_sections_on_end_time", using: :btree
  add_index "sections", ["start_time"], name: "index_sections_on_start_time", using: :btree

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

  create_table "xforms", force: true do |t|
    t.string  "name",                     null: false
    t.string  "field_type",               null: false
    t.string  "default_val"
    t.integer "length_limit"
    t.string  "data"
    t.text    "message"
    t.string  "value_range"
    t.integer "sort",         default: 1
    t.integer "section_id"
  end

  add_index "xforms", ["section_id"], name: "xforms_section_id_fk", using: :btree
  add_index "xforms", ["sort"], name: "index_xforms_on_sort", using: :btree

  add_foreign_key "competes", "contests", name: "competes_contest_id_fk", dependent: :delete

  add_foreign_key "configs", "config_types", name: "configs_config_type_id_fk", dependent: :delete

  add_foreign_key "sections", "competes", name: "sections_compete_id_fk", dependent: :delete

  add_foreign_key "xforms", "sections", name: "xforms_section_id_fk", dependent: :delete

end
