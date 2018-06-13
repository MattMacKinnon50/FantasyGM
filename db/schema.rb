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

ActiveRecord::Schema.define(version: 2018_06_02_003029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contracts", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "team_id"
    t.integer "length", null: false
    t.integer "start_year", null: false
    t.integer "offered_to"
    t.boolean "highest_bid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expires"
    t.string "player_name"
    t.integer "total", null: false
    t.integer "aav", null: false
    t.integer "guaranteed", null: false
    t.index ["player_id"], name: "index_contracts_on_player_id"
    t.index ["team_id"], name: "index_contracts_on_team_id"
  end

  create_table "dead_moneys", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "player_id"
    t.string "name"
    t.integer "year"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_dead_moneys_on_player_id"
    t.index ["team_id"], name: "index_dead_moneys_on_team_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "display_name", limit: 12
    t.integer "league_year"
    t.integer "salary_cap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.bigint "team_id"
    t.string "nfl_team"
    t.string "number"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "position"
    t.string "height"
    t.integer "weight"
    t.string "birth_date"
    t.string "college"
    t.integer "experience"
    t.string "photo_url"
    t.string "bye_week"
    t.string "college_draft_team"
    t.string "college_draft_year"
    t.string "college_draft_round"
    t.integer "college_draft_pick"
    t.boolean "undrafted_free_agent_status"
    t.integer "fantasy_alarm_player_id"
    t.string "sports_radar_player_id"
    t.integer "rotoworld_player_id"
    t.integer "rotowire_player_id"
    t.integer "stats_player_id"
    t.integer "sports_direct_player_id"
    t.integer "xmlteam_player_id"
    t.integer "fanduel_player_id"
    t.integer "draftkings_player_id"
    t.integer "yahoo_player_id"
    t.integer "fantasydraft_player_id"
    t.integer "fantasy_stats_2017"
    t.integer "fantasy_stats_ppr_2017"
    t.string "role", default: "b"
    t.boolean "ps_eligibility", default: false
    t.decimal "height_feet", precision: 4, scale: 3
    t.boolean "eligbile_for_signing", default: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "abbr", null: false
    t.string "city", null: false
    t.string "name", null: false
    t.string "conference"
    t.string "division"
    t.string "head_coach"
    t.string "offensive_coordinator"
    t.string "defensive_coordinator"
    t.string "special_teams_coach"
    t.string "primary_color"
    t.string "secondary_color"
    t.string "tertiary_color"
    t.string "quaternary_color"
    t.string "stadium_name"
    t.string "stadium_city"
    t.string "stadium_state"
    t.string "stadium_country"
    t.string "stadium_capacity"
    t.string "stadium_playing_surface"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo"
    t.string "wordmark"
  end

  create_table "trades", force: :cascade do |t|
    t.integer "team1_id", null: false
    t.integer "team2_id", null: false
    t.string "team1_assets", null: false
    t.string "team2_assets", null: false
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "message"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.string "name"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "trades", "teams"
end
