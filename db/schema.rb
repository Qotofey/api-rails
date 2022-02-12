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

ActiveRecord::Schema.define(version: 2022_02_12_145506) do

  create_table "user", charset: "utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "email"
    t.string "phone"
    t.string "promo"
    t.string "password_digest"
    t.string "gender"
    t.date "birth_date"
    t.datetime "confirmed_at"
    t.datetime "deleted_at"
    t.bigint "created_by_user_id"
    t.bigint "updated_by_user_id"
    t.bigint "deleted_by_user_id"
    t.bigint "confirmed_by_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmed_by_user_id"], name: "index_users_on_confirmed_by_user_id"
    t.index ["created_by_user_id"], name: "index_users_on_created_by_user_id"
    t.index ["deleted_by_user_id"], name: "index_users_on_deleted_by_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["promo"], name: "index_users_on_promo", unique: true
    t.index ["updated_by_user_id"], name: "index_users_on_updated_by_user_id"
  end

  create_table "user_roles", charset: "utf8", force: :cascade do |t|
    t.string "position"
    t.bigint "user_id", null: false
    t.bigint "created_by_user_id"
    t.bigint "updated_by_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_user_id"], name: "index_user_roles_on_created_by_user_id"
    t.index ["updated_by_user_id"], name: "index_user_roles_on_updated_by_user_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "email"
    t.string "phone"
    t.string "promo"
    t.string "password_digest"
    t.string "gender"
    t.date "birth_date"
    t.datetime "confirmed_at"
    t.datetime "deleted_at"
    t.bigint "created_by_user_id"
    t.bigint "updated_by_user_id"
    t.bigint "deleted_by_user_id"
    t.bigint "confirmed_by_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmed_by_user_id"], name: "index_users_on_confirmed_by_user_id"
    t.index ["created_by_user_id"], name: "index_users_on_created_by_user_id"
    t.index ["deleted_by_user_id"], name: "index_users_on_deleted_by_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["promo"], name: "index_users_on_promo", unique: true
    t.index ["updated_by_user_id"], name: "index_users_on_updated_by_user_id"
  end

  add_foreign_key "user_roles", "users"
end
