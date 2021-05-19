# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_15_085657) do

  create_table "attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "file"
    t.bigint "live_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["live_id"], name: "index_attachments_on_live_id"
  end

  create_table "banners", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "image"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "slot"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "banner_type", default: 0, null: false
    t.integer "language", default: 0
  end

  create_table "barrages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "live_id"
    t.string "detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_barrages_on_created_at"
    t.index ["live_id"], name: "index_barrages_on_live_id"
    t.index ["user_id"], name: "index_barrages_on_user_id"
  end

  create_table "case_andits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "detail", size: :long
    t.text "detail_en", size: :long
    t.bigint "case_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["case_id"], name: "index_case_andits_on_case_id"
  end

  create_table "case_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "image"
    t.bigint "case_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["case_id"], name: "index_case_images_on_case_id"
  end

  create_table "cases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.text "detail", size: :long
    t.text "detail_en", size: :long
    t.string "three_d_model"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name_en"
    t.text "video", size: :long
    t.index ["company_id"], name: "index_cases_on_company_id"
    t.index ["name"], name: "index_cases_on_name"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "live_id"
    t.string "detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["live_id"], name: "index_comments_on_live_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "company_type", default: 0, null: false
    t.string "name"
    t.string "name_en"
    t.text "description"
    t.text "description_en"
    t.text "detail", size: :long
    t.text "detail_en", size: :long
    t.bigint "company_classify_relations_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.integer "recommended", default: 0, null: false
    t.string "logo"
    t.bigint "user_id"
    t.string "phone_number"
    t.integer "slot", default: 0
    t.index ["company_classify_relations_id"], name: "index_companies_on_company_classify_relations_id"
    t.index ["company_type"], name: "index_companies_on_company_type"
    t.index ["name"], name: "index_companies_on_name"
    t.index ["name_en"], name: "index_companies_on_name_en"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "company_audits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "company_id"
    t.string "description"
    t.string "description_en"
    t.text "detail", size: :long
    t.text "detail_en", size: :long
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.string "name"
    t.string "name_en"
    t.string "phone_number"
    t.index ["company_id"], name: "index_company_audits_on_company_id"
  end

  create_table "company_classifies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_en", null: false
    t.integer "classify_type", default: 0, null: false
    t.index ["classify_type"], name: "index_company_classifies_on_classify_type"
    t.index ["name"], name: "index_company_classifies_on_name"
    t.index ["name_en"], name: "index_company_classifies_on_name_en"
  end

  create_table "company_classify_relations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "company_classify_id"
    t.index ["company_classify_id"], name: "index_company_classify_relations_on_company_classify_id"
    t.index ["company_id"], name: "index_company_classify_relations_on_company_id"
  end

  create_table "demand_relations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "demand_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_demand_relations_on_company_id"
    t.index ["demand_id"], name: "index_demand_relations_on_demand_id"
  end

  create_table "demands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "company_name"
    t.integer "company_type"
    t.string "scope_of_business"
    t.integer "income_type"
    t.string "contract_name"
    t.string "contract_phone_number"
    t.string "contract_email"
    t.string "contract_address"
    t.integer "demand_type"
    t.integer "product_type"
    t.datetime "end_at"
    t.text "detail", size: :long
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "slot", default: 0
    t.index ["slot"], name: "index_demands_on_slot"
    t.index ["user_id"], name: "index_demands_on_user_id"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "time"
    t.integer "slot", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tags"
    t.integer "event_type"
    t.index ["event_type"], name: "index_events_on_event_type"
    t.index ["slot"], name: "index_events_on_slot"
  end

  create_table "friend_links", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "image"
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "live_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "live_id"
    t.string "image"
    t.string "name"
    t.string "name_en"
    t.text "description", size: :long
    t.text "description_en", size: :long
    t.text "url", size: :long
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["live_id"], name: "index_live_details_on_live_id"
  end

  create_table "lives", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "live_type"
    t.string "name", null: false
    t.string "description"
    t.string "stream_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.integer "status"
    t.bigint "company_id"
    t.string "author"
    t.string "name_en"
    t.string "logo"
    t.integer "source", default: 0
    t.text "source_url", size: :long
    t.boolean "ad_show", default: false
    t.integer "slot", default: 99
    t.index ["company_id"], name: "index_lives_on_company_id"
    t.index ["name"], name: "index_lives_on_name"
    t.index ["slot"], name: "index_lives_on_slot"
  end

  create_table "mobile_apps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "name"
    t.string "version", limit: 50
    t.string "secret", limit: 32
    t.string "app_key", limit: 32
    t.date "deprecated_at"
    t.string "attachment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["app_key"], name: "index_mobile_apps_on_app_key"
    t.index ["name", "version"], name: "index_mobile_apps_on_name_and_version", unique: true
  end

  create_table "new_classifies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
  end

  create_table "news", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.text "detail", size: :long
    t.text "detail_en", size: :long
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "new_type", default: 0, null: false
    t.string "image"
    t.bigint "new_classify_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "slot", default: 0
    t.index ["new_classify_id"], name: "index_news_on_new_classify_id"
    t.index ["new_type"], name: "index_news_on_new_type"
    t.index ["slot"], name: "index_news_on_slot"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "body"
    t.boolean "is_active", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["is_active"], name: "index_notifications_on_is_active"
  end

  create_table "staffs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_live_subscribes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "live_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["live_id"], name: "index_user_live_subscribes_on_live_id"
    t.index ["user_id"], name: "index_user_live_subscribes_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "api_token"
    t.string "invite_code"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_type", default: 0, null: false
    t.string "user_remask"
    t.string "company_name"
    t.string "phone_number"
    t.string "name"
    t.string "image"
    t.index ["email"], name: "index_users_on_email"
    t.index ["invite_code"], name: "index_users_on_invite_code"
    t.index ["lft"], name: "index_users_on_lft"
    t.index ["parent_id"], name: "index_users_on_parent_id"
    t.index ["rgt"], name: "index_users_on_rgt"
  end

end
