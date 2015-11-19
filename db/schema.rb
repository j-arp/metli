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

ActiveRecord::Schema.define(version: 20151118211013) do

  create_table "actions", force: :cascade do |t|
    t.string   "content"
    t.integer  "call_to_action_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "actions", ["call_to_action_id"], name: "index_actions_on_call_to_action_id"

  create_table "call_to_actions", force: :cascade do |t|
    t.string   "call"
    t.integer  "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "call_to_actions", ["chapter_id"], name: "index_call_to_actions_on_chapter_id"

  create_table "chapters", force: :cascade do |t|
    t.integer  "number"
    t.string   "title"
    t.text     "content"
    t.date     "published_on"
    t.integer  "author_id"
    t.integer  "story_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "teaser"
  end

  add_index "chapters", ["author_id"], name: "index_chapters_on_author_id"
  add_index "chapters", ["story_id"], name: "index_chapters_on_story_id"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "stories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.text     "taxonomy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.string   "permalink"
    t.text     "about"
  end

  add_index "stories", ["permalink"], name: "index_stories_on_permalink"

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "user_id"
    t.boolean  "author",     default: false
    t.boolean  "privileged", default: false
    t.boolean  "active",     default: true
    t.string   "username"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "subscriptions", ["story_id"], name: "index_subscriptions_on_story_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.boolean  "active",     default: true
    t.boolean  "author",     default: false
    t.boolean  "privileged", default: false
    t.integer  "story_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "super_user", default: false
  end

  add_index "users", ["story_id"], name: "index_users_on_story_id"

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "votable_type"
    t.string   "votable_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
