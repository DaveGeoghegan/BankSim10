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

ActiveRecord::Schema.define(version: 2022_04_10_163914) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "assumptions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "product"
    t.string "channel"
    t.string "band"
    t.integer "month"
    t.string "decision"
    t.string "bucket"
    t.string "value"
    t.string "variable"
    t.index ["product", "band", "channel", "month"], name: "index_assumptions_on_product_and_band_and_channel_and_month"
  end

  create_table "decisions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "team_round_id"
    t.integer "input_item_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "field_name"
    t.string "field_value"
    t.string "original_value"
    t.boolean "is_modified"
    t.index ["team_round_id", "field_name"], name: "index_decisions_on_team_round_id_and_field_name"
  end

  create_table "graph_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "graph_id"
    t.string "x_labels"
    t.string "graph_label"
    t.string "data"
    t.string "y_min"
    t.string "y_max"
    t.string "y_step"
    t.string "datatype"
    t.integer "team_round_id"
    t.string "number_of_decimal_places"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "is_percent"
    t.integer "is_dollar"
  end

  create_table "input_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "identifier"
    t.string "label"
    t.string "kind"
    t.integer "input_screen_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "default_value"
    t.float "max_value"
    t.float "min_value"
    t.integer "simulation_id"
    t.text "options"
    t.integer "number_of_decimal_places"
    t.text "infolink"
    t.string "value_label"
  end

  create_table "input_screens", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "navigation_label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identifier"
    t.integer "input_screen_number"
  end

  create_table "inputs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.string "label"
    t.integer "min"
    t.integer "max"
    t.string "string_default"
    t.string "integer_default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "related_reports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.integer "input_screen_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "round_input_screens", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "round_id"
    t.integer "input_screen_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rounds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "round_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "simulation_id"
    t.string "economic_data_file_name"
    t.string "economic_data_content_type"
    t.integer "economic_data_file_size"
    t.datetime "economic_data_updated_at"
    t.string "debrief_file_name"
    t.string "debrief_content_type"
    t.integer "debrief_file_size"
    t.datetime "debrief_updated_at"
    t.boolean "is_enabled"
    t.boolean "is_active"
    t.boolean "is_closed"
  end

  create_table "simulations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_rounds"
    t.boolean "is_active"
    t.text "intro_text"
    t.text "welcome_text"
    t.boolean "final_reports_enabled", default: false
  end

  create_table "team_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.integer "team_round_id"
    t.string "product"
    t.string "band"
    t.string "channel"
    t.integer "vintage"
    t.integer "month"
    t.float "value"
    t.index ["name", "team_round_id", "product", "channel", "band", "month"], name: "team_date_index"
    t.index ["product", "team_round_id", "band", "month", "name"], name: "team_data_for_mci"
    t.index ["product", "team_round_id", "month", "name"], name: "team_data_for_mci_3"
    t.index ["team_round_id", "product", "band", "channel", "month", "vintage"], name: "team_data_w_vintage_index"
  end

  create_table "team_round_input_screens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "team_round_id"
    t.integer "input_screen_id"
    t.boolean "was_visited"
    t.boolean "data_entered"
  end

  create_table "team_rounds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "team_id"
    t.integer "round_id"
    t.boolean "is_finished"
    t.datetime "finish_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "report_file_name"
    t.string "report_content_type"
    t.integer "report_file_size"
    t.datetime "report_updated_at"
    t.string "debrief_file_name"
    t.string "debrief_content_type"
    t.integer "debrief_file_size"
    t.datetime "debrief_updated_at"
    t.boolean "is_submitted", default: false
    t.string "graph_data_file_name"
    t.integer "attempts"
  end

  create_table "teams", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "simulation_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "is_admin", default: false
    t.index ["name"], name: "index_teams_on_name", unique: true
    t.index ["reset_password_token"], name: "index_teams_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
