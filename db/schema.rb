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

ActiveRecord::Schema.define(version: 2020_07_28_123356) do

  create_table "account_specialities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "used_at"
    t.boolean "used"
    t.bigint "speciality_id"
    t.bigint "patient_account_id"
    t.bigint "medic_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medic_profile_id"], name: "index_account_specialities_on_medic_profile_id"
    t.index ["patient_account_id", "speciality_id"], name: "ac_sp_index", unique: true
    t.index ["patient_account_id"], name: "index_account_specialities_on_patient_account_id"
    t.index ["speciality_id"], name: "index_account_specialities_on_speciality_id"
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zipcode"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "clinic_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_clinic_profiles_on_address_id"
  end

  create_table "clinics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "clinic_profile_id"
    t.index ["clinic_profile_id"], name: "index_clinics_on_clinic_profile_id"
  end

  create_table "medic_evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.integer "rating"
    t.bigint "medic_profile_id"
    t.bigint "patient_profile_id"
    t.bigint "scheduling_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medic_profile_id"], name: "index_medic_evaluations_on_medic_profile_id"
    t.index ["patient_profile_id"], name: "index_medic_evaluations_on_patient_profile_id"
    t.index ["scheduling_id"], name: "index_medic_evaluations_on_scheduling_id"
  end

  create_table "medic_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "genre"
    t.date "birth_date"
    t.decimal "height", precision: 4, scale: 2
    t.string "bloodtype"
    t.string "telephone"
    t.decimal "weight", precision: 4, scale: 2
    t.string "experience"
    t.decimal "rating", precision: 4, scale: 2
    t.integer "rating_qtd"
    t.boolean "complete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "address_id"
    t.index ["address_id"], name: "index_medic_profiles_on_address_id"
  end

  create_table "medic_profiles_specialities", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "speciality_id"
    t.integer "medic_profile_id"
    t.index ["speciality_id", "medic_profile_id"], name: "sp_md_index"
  end

  create_table "medic_work_schedulings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "duration"
    t.time "start_at"
    t.time "end_at"
    t.time "interval_start_at"
    t.time "interval_end_at"
    t.string "info"
    t.string "days_of_week"
    t.bigint "clinic_profile_id"
    t.bigint "speciality_id"
    t.string "complement"
    t.integer "per_day"
    t.date "last"
    t.integer "counter_of_day"
    t.string "medic_name"
    t.string "clinic_name"
    t.string "speciality_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "medic_profile_id"
    t.index ["clinic_profile_id"], name: "index_medic_work_schedulings_on_clinic_profile_id"
    t.index ["medic_profile_id"], name: "index_medic_work_schedulings_on_medic_profile_id"
    t.index ["speciality_id"], name: "index_medic_work_schedulings_on_speciality_id"
  end

  create_table "medics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider", default: "cpf", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "name"
    t.string "cpf"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "medic_profile_id"
    t.index ["cpf"], name: "index_medics_on_cpf", unique: true
    t.index ["email"], name: "index_medics_on_email", unique: true
    t.index ["medic_profile_id"], name: "index_medics_on_medic_profile_id"
    t.index ["reset_password_token"], name: "index_medics_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_medics_on_uid_and_provider", unique: true
  end

  create_table "message_managers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "message_count"
    t.boolean "active"
    t.bigint "patient_profile_id"
    t.bigint "medic_profile_id"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_message_managers_on_admin_id"
    t.index ["medic_profile_id"], name: "index_message_managers_on_medic_profile_id"
    t.index ["patient_profile_id"], name: "index_message_managers_on_patient_profile_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "message"
    t.string "from"
    t.boolean "from_client"
    t.boolean "active"
    t.bigint "message_manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_manager_id"], name: "index_messages_on_message_manager_id"
  end

  create_table "patient_accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "patient_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_profile_id"], name: "index_patient_accounts_on_patient_profile_id"
  end

  create_table "patient_files", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.integer "category"
    t.bigint "patient_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_account_id"], name: "index_patient_files_on_patient_account_id"
  end

  create_table "patient_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "genre"
    t.date "birth_date"
    t.decimal "height", precision: 4, scale: 2
    t.string "bloodtype"
    t.string "telephone"
    t.decimal "weight", precision: 4, scale: 2
    t.boolean "complete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "address_id"
    t.index ["address_id"], name: "index_patient_profiles_on_address_id"
  end

  create_table "patients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider", default: "cpf", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "name"
    t.string "cpf"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "patient_profile_id"
    t.index ["cpf"], name: "index_patients_on_cpf", unique: true
    t.index ["email"], name: "index_patients_on_email", unique: true
    t.index ["patient_profile_id"], name: "index_patients_on_patient_profile_id"
    t.index ["reset_password_token"], name: "index_patients_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_patients_on_uid_and_provider", unique: true
  end

  create_table "schedulings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "for_date"
    t.time "for_time"
    t.boolean "consulted"
    t.boolean "rated"
    t.datetime "consulted_at"
    t.bigint "medic_work_scheduling_id"
    t.bigint "medic_profile_id"
    t.bigint "patient_profile_id"
    t.bigint "speciality_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medic_profile_id"], name: "index_schedulings_on_medic_profile_id"
    t.index ["medic_work_scheduling_id"], name: "index_schedulings_on_medic_work_scheduling_id"
    t.index ["patient_profile_id"], name: "index_schedulings_on_patient_profile_id"
    t.index ["speciality_id"], name: "index_schedulings_on_speciality_id"
  end

  create_table "specialities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "priv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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

  add_foreign_key "account_specialities", "medic_profiles"
  add_foreign_key "account_specialities", "patient_accounts"
  add_foreign_key "account_specialities", "specialities"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clinic_profiles", "addresses"
  add_foreign_key "clinics", "clinic_profiles"
  add_foreign_key "medic_evaluations", "medic_profiles"
  add_foreign_key "medic_evaluations", "patient_profiles"
  add_foreign_key "medic_evaluations", "schedulings"
  add_foreign_key "medic_profiles", "addresses"
  add_foreign_key "medic_work_schedulings", "clinic_profiles"
  add_foreign_key "medic_work_schedulings", "medic_profiles"
  add_foreign_key "medic_work_schedulings", "specialities"
  add_foreign_key "medics", "medic_profiles"
  add_foreign_key "message_managers", "admins"
  add_foreign_key "message_managers", "medic_profiles"
  add_foreign_key "message_managers", "patient_profiles"
  add_foreign_key "messages", "message_managers"
  add_foreign_key "patient_accounts", "patient_profiles"
  add_foreign_key "patient_files", "patient_accounts"
  add_foreign_key "patient_profiles", "addresses"
  add_foreign_key "patients", "patient_profiles"
  add_foreign_key "schedulings", "medic_profiles"
  add_foreign_key "schedulings", "medic_work_schedulings"
  add_foreign_key "schedulings", "patient_profiles"
  add_foreign_key "schedulings", "specialities"
end
