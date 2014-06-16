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

ActiveRecord::Schema.define(version: 20140616062949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "responses", force: true do |t|
    t.integer  "topic_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["topic_id"], name: "index_responses_on_topic_id", using: :btree

  create_table "topics", force: true do |t|
    t.string   "name"
    t.string   "pattern"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "subscriber_id"
  end

  add_index "topics", ["subscriber_id"], name: "index_topics_on_subscriber_id", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "full_name"
    t.string   "nick_name"
    t.string   "display_name"
    t.string   "avatar_big"
    t.string   "avatar_small"
    t.string   "avatar_medium"
    t.string   "plurk_uid"
    t.string   "token"
    t.string   "secret"
    t.text     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "friends_cache"
    t.datetime "friends_cache_updated_at"
  end

  add_index "users", ["nick_name"], name: "index_users_on_nick_name", using: :btree
  add_index "users", ["plurk_uid"], name: "index_users_on_plurk_uid", using: :btree

end
