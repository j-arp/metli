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

ActiveRecord::Schema.define(version: 20151208203959) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string   "content"
    t.integer  "call_to_action_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "actions", ["call_to_action_id"], name: "index_actions_on_call_to_action_id", using: :btree

  create_table "call_to_actions", force: :cascade do |t|
    t.string   "call"
    t.integer  "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "call_to_actions", ["chapter_id"], name: "index_call_to_actions_on_chapter_id", using: :btree

  create_table "chapters", force: :cascade do |t|
    t.integer  "number"
    t.string   "title"
    t.text     "content"
    t.date     "published_on"
    t.integer  "user_id"
    t.integer  "story_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "teaser"
    t.datetime "vote_ends_on"
    t.string   "voting_ends_after"
  end

  add_index "chapters", ["story_id"], name: "index_chapters_on_story_id", using: :btree
  add_index "chapters", ["user_id"], name: "index_chapters_on_user_id", using: :btree

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

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "chapter_id"
    t.boolean  "is_flagged"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["chapter_id"], name: "index_comments_on_chapter_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "invites", force: :cascade do |t|
    t.string   "key"
    t.boolean  "used",       default: false
    t.integer  "user_id"
    t.datetime "used_on"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.text     "taxonomy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.string   "permalink"
    t.text     "about"
    t.integer  "created_by"
    t.integer  "user_id"
  end

  add_index "stories", ["permalink"], name: "index_stories_on_permalink", using: :btree
  add_index "stories", ["user_id"], name: "index_stories_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "user_id"
    t.boolean  "author",                    default: false
    t.boolean  "privileged",                default: false
    t.boolean  "active",                    default: true
    t.string   "username"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "send_email",                default: false
    t.boolean  "send_push",                 default: false
    t.integer  "last_read_chapter_number"
    t.integer  "last_voted_chapter_number"
  end

  add_index "subscriptions", ["story_id"], name: "index_subscriptions_on_story_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "super_user", default: false
    t.string   "image"
    t.boolean  "deleted",    default: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "votable_type"
    t.integer  "votable_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "actions", "call_to_actions"
  add_foreign_key "call_to_actions", "chapters"
  add_foreign_key "chapters", "stories"
  add_foreign_key "chapters", "users"
  add_foreign_key "comments", "chapters"
  add_foreign_key "comments", "users"
  add_foreign_key "invites", "users"
  add_foreign_key "stories", "users"
  add_foreign_key "subscriptions", "stories"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "votes", "users"
end
