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

ActiveRecord::Schema.define(version: 2021_02_06_170447) do

  create_table "chats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "order", null: false
    t.string "subject_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "messages_count", default: 0, null: false
    t.index ["order", "subject_token"], name: "index_chats_on_order_and_subject_token", unique: true
    t.index ["subject_token"], name: "fk_rails_eeacd2feab"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "order", null: false
    t.bigint "chat_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["order", "chat_id"], name: "index_messages_on_order_and_chat_id", unique: true
  end

  create_table "subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chats_count", default: 0, null: false
    t.index ["token"], name: "index_subjects_on_token", unique: true
  end

  add_foreign_key "chats", "subjects", column: "subject_token", primary_key: "token"
  add_foreign_key "messages", "chats"
end
