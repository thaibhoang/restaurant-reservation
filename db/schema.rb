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

ActiveRecord::Schema[7.1].define(version: 2024_06_05_115756) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "businesses", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_businesses_on_email", unique: true
    t.index ["reset_password_token"], name: "index_businesses_on_reset_password_token", unique: true
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_dishes_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_groups_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_menus_on_business_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "party_size"
    t.datetime "time"
    t.string "status", default: "holded"
    t.string "cancel_log"
    t.integer "occation"
    t.string "special_request"
    t.bigint "user_id", null: false
    t.bigint "table_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_reservations_on_table_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "restaurant_profiles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "phone"
    t.string "address"
    t.string "price"
    t.string "cuisine"
    t.string "dining_style"
    t.string "dress_code"
    t.string "parking_details"
    t.string "payment_options"
    t.string "executive_chef"
    t.string "website"
    t.text "catering"
    t.text "private_party_facilities"
    t.text "additional"
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "opening_time"
    t.time "closing_time"
    t.integer "dining_duration", default: 180, null: false
    t.index ["business_id"], name: "index_restaurant_profiles_on_business_id"
  end

  create_table "seating_options", force: :cascade do |t|
    t.string "name"
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "indestructible", default: false
    t.index ["business_id", "name"], name: "index_seating_options_on_business_id_and_name", unique: true
    t.index ["business_id"], name: "index_seating_options_on_business_id"
  end

  create_table "serve_sizes", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 7, scale: 2
    t.bigint "dish_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_serve_sizes_on_dish_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "number", null: false
    t.integer "seats", null: false
    t.bigint "business_id", null: false
    t.bigint "seating_option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_tables_on_business_id"
    t.index ["number", "business_id"], name: "index_tables_on_number_and_business_id", unique: true
    t.index ["seating_option_id"], name: "index_tables_on_seating_option_id"
    t.index ["seats"], name: "index_tables_on_seats"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "dishes", "groups"
  add_foreign_key "groups", "menus"
  add_foreign_key "menus", "businesses"
  add_foreign_key "reservations", "tables"
  add_foreign_key "reservations", "users"
  add_foreign_key "restaurant_profiles", "businesses"
  add_foreign_key "seating_options", "businesses"
  add_foreign_key "serve_sizes", "dishes"
  add_foreign_key "tables", "businesses"
  add_foreign_key "tables", "seating_options"
end
