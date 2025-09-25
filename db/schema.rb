# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_09_25_010503) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "postal_code"
    t.string "prefecture"
    t.string "city"
    t.string "district"
    t.string "block"
    t.string "building_name"
    t.string "number"
    t.string "description"
    t.bigint "type_place_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["type_place_id"], name: "index_addresses_on_type_place_id"
  end

  create_table "chats", force: :cascade do |t|
    t.string "title"
    t.bigint "users_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_chats_on_users_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "telephone"
    t.string "email"
    t.string "relationship"
    t.float "latitude"
    t.float "longitude"
    t.string "avatar"
    t.bigint "family_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_contacts_on_family_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hazards", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "occurence"
    t.string "type"
    t.float "latitude"
    t.float "longitude"
    t.float "magnitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "list_addresses", force: :cascade do |t|
    t.bigint "address_id", null: false
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_list_addresses_on_address_id"
    t.index ["contact_id"], name: "index_list_addresses_on_contact_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chats_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chats_id"], name: "index_messages_on_chats_id"
  end

  create_table "type_places", force: :cascade do |t|
    t.string "description"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "contact_id"
    t.string "avatar"
    t.index ["contact_id"], name: "index_users_on_contact_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "users", "contacts"
end
