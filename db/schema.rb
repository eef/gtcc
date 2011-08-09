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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110125161177) do

  create_table "car_classes", :force => true do |t|
    t.integer  "league_id"
    t.string   "name"
    t.integer  "max_players"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cars", :force => true do |t|
    t.string   "name"
    t.integer  "manufacturer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cars_leagues", :id => false, :force => true do |t|
    t.integer  "car_id"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_settings", :force => true do |t|
    t.string   "mechanical"
    t.string   "game_mode"
    t.string   "penalty"
    t.string   "tyre_fuel_depletion"
    t.string   "grip_reduction"
    t.string   "grid_order"
    t.string   "start_type"
    t.string   "boost"
    t.integer  "shuffle_ratio"
    t.integer  "race_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
  end

  create_table "league_cars", :force => true do |t|
    t.integer  "league_id"
    t.integer  "car_id"
    t.integer  "amount"
    t.string   "restrictions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "car_class_id"
    t.integer  "used_amount",  :default => 0
    t.boolean  "allowed",      :default => false
    t.string   "car_name"
  end

  create_table "league_entries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "car_class_id"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_car_id"
  end

  create_table "league_points", :force => true do |t|
    t.integer  "position"
    t.integer  "points"
    t.integer  "league_id"
    t.integer  "race_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.integer  "max_players"
    t.integer  "organiser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "open",         :default => false
  end

  create_table "leagues_users", :id => false, :force => true do |t|
    t.integer  "league_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "track_type_id"
  end

  create_table "manufacturers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "owned_cars", :force => true do |t|
    t.string   "nickname"
    t.integer  "car_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_data_file_name"
    t.string   "photo_data_content_type"
    t.integer  "photo_data_file_size"
    t.datetime "photo_data_updated_at"
    t.string   "title"
    t.text     "description"
    t.integer  "owner_id"
  end

  create_table "race_regulations", :force => true do |t|
    t.boolean  "skid_recovery"
    t.boolean  "active_steering"
    t.boolean  "asm"
    t.boolean  "driving_line"
    t.boolean  "tcs"
    t.string   "car_restriction"
    t.integer  "performance_points", :default => 0
    t.integer  "power",              :default => 0
    t.integer  "weight",             :default => 0
    t.string   "tyre_restrictions"
    t.integer  "race_id"
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
  end

  create_table "races", :force => true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.integer  "track_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organiser_id"
    t.datetime "start_time"
    t.integer  "laps",         :default => 1
    t.string   "timezone",     :default => "UTC"
    t.string   "psn_race_id"
    t.string   "race_type"
    t.integer  "max_players",  :default => 2
    t.boolean  "public",       :default => true
    t.integer  "league_id"
    t.boolean  "open",         :default => true
  end

  create_table "races_users", :id => false, :force => true do |t|
    t.integer  "race_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "user_id"
    t.integer  "race_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
    t.integer  "car_class_id"
  end

  create_table "setting_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "setup_group_id"
  end

  create_table "settings", :force => true do |t|
    t.string   "value"
    t.integer  "setup_group_id"
    t.integer  "tuning_id"
    t.integer  "setting_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "setup_groups", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "standings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "car_class_id"
    t.integer  "league_entry_id"
  end

  create_table "track_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "track_type_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tunings", :force => true do |t|
    t.string   "name"
    t.integer  "car_id"
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",      :default => false
  end

  create_table "tunings_upgrades", :id => false, :force => true do |t|
    t.integer  "tuning_id"
    t.integer  "upgrade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "upgrade_groups", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "upgrades", :force => true do |t|
    t.string   "name"
    t.integer  "upgrade_group_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",       :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",       :null => false
    t.string   "password_salt",                       :default => "",       :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "roles",                               :default => "--- []"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "psn_name"
    t.string   "reddit_name"
    t.integer  "age"
    t.string   "timezone",                            :default => "UTC"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "confirmation_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
