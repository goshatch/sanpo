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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120304140728) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "walk_id"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "photos", :force => true do |t|
    t.integer  "walk_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "user_locations", :force => true do |t|
    t.integer  "user_id"
    t.string   "ip_address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                       :default => "",    :null => false
    t.string   "encrypted_password",           :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                               :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "admin",                                       :default => false, :null => false
    t.boolean  "mail_comment_notification",                   :default => true
    t.boolean  "mail_follow_notification",                    :default => true
    t.boolean  "mail_local_walk_notification",                :default => true
    t.boolean  "mail_weekly_digest",                          :default => true
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "walks", :force => true do |t|
    t.string   "title",        :limit => 70,                    :null => false
    t.text     "description"
    t.text     "notes"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "length",                     :default => 0
    t.boolean  "published",                  :default => false, :null => false
    t.datetime "published_at"
    t.float    "latitude",     :limit => 20
    t.float    "longitude",    :limit => 20
    t.string   "location"
  end

  create_table "waypoints", :force => true do |t|
    t.string   "label"
    t.decimal  "latitude",   :precision => 20, :scale => 16
    t.decimal  "longitude",  :precision => 20, :scale => 16
    t.integer  "step_num"
    t.integer  "walk_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
