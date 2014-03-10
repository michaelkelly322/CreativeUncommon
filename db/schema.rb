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

ActiveRecord::Schema.define(version: 20140310202535) do

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "bio"
    t.string   "email_confirmation"
    t.string   "username"
    t.string   "session_key"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["session_key"], name: "index_users_on_session_key"
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "works", force: true do |t|
    t.string   "blurb"
    t.string   "title"
    t.string   "author_name"
    t.text     "body"
    t.boolean  "mature"
    t.boolean  "draft"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "read_count"
    t.string   "genre"
    t.integer  "word_count"
    t.integer  "downloaded"
    t.decimal  "donated"
  end

  add_index "works", ["created_at"], name: "index_works_on_created_at"
  add_index "works", ["read_count"], name: "index_works_on_read_count"
  add_index "works", ["user_id"], name: "index_works_on_user_id"

end
