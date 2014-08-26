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

ActiveRecord::Schema.define(version: 20140826093700) do

  create_table "articles", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "tags"
    t.text     "content"
    t.integer  "view_count"
    t.integer  "star_count"
    t.integer  "comments_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["comments_count"], name: "index_articles_on_comments_count", using: :btree
  add_index "articles", ["created_at"], name: "index_articles_on_created_at", using: :btree
  add_index "articles", ["star_count"], name: "index_articles_on_star_count", using: :btree
  add_index "articles", ["title"], name: "index_articles_on_title", using: :btree
  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree
  add_index "articles", ["view_count"], name: "index_articles_on_view_count", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "articles_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["articles_count"], name: "index_categories_on_articles_count", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.boolean  "admin"
    t.datetime "last_login_time"
    t.datetime "last_reply_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
