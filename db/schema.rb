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

ActiveRecord::Schema.define(version: 2019_06_05_104023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_conversations_on_group_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "group_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "currency"
    t.string "description"
    t.index ["group_id"], name: "index_expenses_on_group_id"
  end

  create_table "group_memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.index ["group_id"], name: "index_group_memberships_on_group_id"
    t.index ["user_id"], name: "index_group_memberships_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "list_items", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.text "description"
    t.string "photo"
    t.integer "upvote", default: 0
    t.integer "downvote", default: 0
    t.bigint "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["list_id"], name: "index_list_items_on_list_id"
    t.index ["user_id"], name: "index_list_items_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["group_id"], name: "index_lists_on_group_id"
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "splits", force: :cascade do |t|
    t.bigint "expense_id"
    t.bigint "user_id"
    t.float "customsplit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "paid"
    t.boolean "settled", default: false
    t.float "homefxtranslation"
    t.float "fx"
    t.index ["expense_id"], name: "index_splits_on_expense_id"
    t.index ["user_id"], name: "index_splits_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.string "homecurrency"
    t.string "provider"
    t.string "uid"
    t.string "facebook_picture_url"
    t.string "first_name"
    t.string "last_name"
    t.string "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "list_item_id"
    t.boolean "upvote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_item_id"], name: "index_votes_on_list_item_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "conversations", "groups"
  add_foreign_key "expenses", "groups"
  add_foreign_key "group_memberships", "groups"
  add_foreign_key "group_memberships", "users"
  add_foreign_key "list_items", "lists"
  add_foreign_key "list_items", "users"
  add_foreign_key "lists", "groups"
  add_foreign_key "lists", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "splits", "expenses"
  add_foreign_key "splits", "users"
  add_foreign_key "votes", "list_items"
  add_foreign_key "votes", "users"
end
