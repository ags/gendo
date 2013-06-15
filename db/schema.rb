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

ActiveRecord::Schema.define(version: 20130615004449) do

  create_table "apps", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "name",       null: false
    t.string   "slug",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sql_events", force: true do |t|
    t.integer  "transaction_id"
    t.string   "sql",            limit: 1024
    t.datetime "started_at"
    t.datetime "ended_at"
    t.float    "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "transactions", force: true do |t|
    t.string   "controller",   null: false
    t.string   "action",       null: false
    t.string   "path"
    t.string   "format"
    t.string   "method"
    t.integer  "status"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.float    "db_runtime"
    t.float    "view_runtime"
    t.float    "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id",       null: false
  end

  create_table "user_access_tokens", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "token",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "view_events", force: true do |t|
    t.integer  "transaction_id"
    t.string   "identifier",     null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.float    "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
