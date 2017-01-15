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

ActiveRecord::Schema.define(version: 20170115154745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "competitions", force: :cascade do |t|
    t.string   "title_ru"
    t.string   "title_en"
    t.string   "title_de"
    t.integer  "region_id"
    t.integer  "sofa_score_id"
    t.string   "sofa_score_slug"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
  end

  add_index "competitions", ["region_id"], name: "index_competitions_on_region_id", using: :btree
  add_index "competitions", ["sofa_score_id"], name: "index_competitions_on_sofa_score_id", using: :btree
  add_index "competitions", ["sofa_score_slug"], name: "index_competitions_on_sofa_score_slug", using: :btree

  create_table "event_statuses", force: :cascade do |t|
    t.integer  "code"
    t.string   "description"
    t.string   "type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "is_finished",    default: false
    t.boolean  "is_interrupted", default: false
    t.boolean  "in_process",     default: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "external_id"
    t.integer  "home_score",      default: 0
    t.integer  "away_score",      default: 0
    t.hstore   "home_scores"
    t.hstore   "away_scores"
    t.integer  "event_status_id"
    t.string   "name"
    t.datetime "started_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "venue_id"
    t.integer  "referee_id"
    t.integer  "season_id"
    t.integer  "competition_id"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
  end

  add_index "events", ["away_team_id"], name: "index_events_on_away_team_id", using: :btree
  add_index "events", ["competition_id"], name: "index_events_on_competition_id", using: :btree
  add_index "events", ["event_status_id"], name: "index_events_on_event_status_id", using: :btree
  add_index "events", ["external_id"], name: "index_events_on_external_id", using: :btree
  add_index "events", ["home_team_id"], name: "index_events_on_home_team_id", using: :btree
  add_index "events", ["referee_id"], name: "index_events_on_referee_id", using: :btree
  add_index "events", ["season_id"], name: "index_events_on_season_id", using: :btree
  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

  create_table "incidents", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.integer  "time",            default: 0
    t.integer  "added_time",      default: 0
    t.string   "incident_type"
    t.string   "incident_class"
    t.string   "description"
    t.hstore   "params"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "external_id"
    t.json     "extended_params"
    t.boolean  "is_home"
    t.integer  "temp_event_id"
    t.integer  "event_id"
  end

  add_index "incidents", ["event_id"], name: "index_incidents_on_event_id", using: :btree
  add_index "incidents", ["external_id"], name: "index_incidents_on_external_id", using: :btree
  add_index "incidents", ["player_id"], name: "index_incidents_on_player_id", using: :btree
  add_index "incidents", ["team_id"], name: "index_incidents_on_team_id", using: :btree
  add_index "incidents", ["temp_event_id"], name: "index_incidents_on_temp_event_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "short_name"
    t.integer  "external_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "players", ["external_id"], name: "index_players_on_external_id", using: :btree

  create_table "referees", force: :cascade do |t|
    t.string   "name"
    t.integer  "external_id"
    t.string   "country"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "referees", ["external_id"], name: "index_referees_on_external_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "title_ru"
    t.string   "title_en"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "sofa_score_id"
    t.string   "title_de"
    t.string   "sofa_score_slug"
    t.integer  "competitions_count"
    t.integer  "sport_id"
  end

  add_index "regions", ["sofa_score_id"], name: "index_regions_on_sofa_score_id", using: :btree
  add_index "regions", ["sofa_score_slug"], name: "index_regions_on_sofa_score_slug", using: :btree
  add_index "regions", ["sport_id"], name: "index_regions_on_sport_id", using: :btree

  create_table "seasons", force: :cascade do |t|
    t.integer  "competition_id"
    t.string   "name"
    t.string   "slug"
    t.string   "year"
    t.integer  "external_id"
    t.boolean  "is_active"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "dates_loaded",               default: false
    t.integer  "events_last_load_timestamp"
  end

  add_index "seasons", ["competition_id"], name: "index_seasons_on_competition_id", using: :btree
  add_index "seasons", ["external_id"], name: "index_seasons_on_external_id", using: :btree

  create_table "sports", force: :cascade do |t|
    t.string   "title_ru"
    t.string   "title_en"
    t.string   "title_de"
    t.string   "sofa_score_slug"
    t.integer  "sofa_score_id"
    t.integer  "regions_count",      default: 0, null: false
    t.integer  "competitions_count", default: 0, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "sports", ["sofa_score_id"], name: "index_sports_on_sofa_score_id", using: :btree

  create_table "stadia", force: :cascade do |t|
    t.string   "title_ru"
    t.string   "title_en"
    t.string   "title_de"
    t.integer  "capacity"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "title_ru"
    t.string   "title_en"
    t.string   "title_de"
    t.string   "full_title_ru"
    t.string   "full_title_en"
    t.string   "full_title_de"
    t.string   "sofa_score_slug"
    t.integer  "sofa_score_id"
    t.integer  "stadium_id"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "simple_title_en"
  end

  add_index "teams", ["stadium_id"], name: "index_teams_on_stadium_id", using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "country"
    t.string   "city"
    t.string   "stadium_name"
    t.integer  "stadium_capacity"
    t.integer  "external_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "venues", ["external_id"], name: "index_venues_on_external_id", using: :btree

  add_foreign_key "competitions", "regions"
  add_foreign_key "events", "competitions"
  add_foreign_key "events", "event_statuses"
  add_foreign_key "events", "referees"
  add_foreign_key "events", "seasons"
  add_foreign_key "events", "venues"
  add_foreign_key "incidents", "events"
  add_foreign_key "incidents", "players"
  add_foreign_key "incidents", "teams"
  add_foreign_key "regions", "sports"
  add_foreign_key "seasons", "competitions"
  add_foreign_key "teams", "stadia"
end
