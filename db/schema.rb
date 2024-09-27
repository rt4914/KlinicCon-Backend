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

ActiveRecord::Schema[7.1].define(version: 2024_09_27_190543) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "pin_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "degrees", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctor_profiles", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.datetime "date_of_birth"
    t.bigint "specialization_id"
    t.bigint "degree_id"
    t.bigint "institute_id"
    t.integer "year_of_completion"
    t.integer "year_of_experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["degree_id"], name: "index_doctor_profiles_on_degree_id"
    t.index ["institute_id"], name: "index_doctor_profiles_on_institute_id"
    t.index ["specialization_id"], name: "index_doctor_profiles_on_specialization_id"
  end

  create_table "institutes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_institutes_on_name", unique: true
  end

  create_table "patient_profiles", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.datetime "date_of_birth"
    t.string "blood_group"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_patient_profiles_on_address_id"
  end

  create_table "registration_councils", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "patient_profile_id"
    t.bigint "doctor_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_profile_id"], name: "index_reviews_on_doctor_profile_id"
    t.index ["patient_profile_id"], name: "index_reviews_on_patient_profile_id"
  end

  create_table "specializations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_specializations_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "jti", null: false
    t.bigint "patient_profile_id"
    t.bigint "doctor_profile_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["doctor_profile_id"], name: "index_users_on_doctor_profile_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["patient_profile_id"], name: "index_users_on_patient_profile_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "doctor_profiles", "degrees"
  add_foreign_key "doctor_profiles", "institutes"
  add_foreign_key "doctor_profiles", "specializations"
  add_foreign_key "patient_profiles", "addresses"
  add_foreign_key "reviews", "doctor_profiles"
  add_foreign_key "reviews", "patient_profiles"
  add_foreign_key "users", "doctor_profiles"
  add_foreign_key "users", "patient_profiles"
end
