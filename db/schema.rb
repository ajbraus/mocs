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

ActiveRecord::Schema.define(:version => 20130828221100) do

  create_table "activities", :force => true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "activities", ["owner_id", "owner_type"], :name => "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], :name => "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], :name => "index_activities_on_trackable_id_and_trackable_type"

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "commitments", :force => true do |t|
    t.integer  "committed_user_id"
    t.integer  "commitment_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "progress",          :default => 0
    t.boolean  "paid",              :default => false
    t.boolean  "paid_out",          :default => false
  end

  add_index "commitments", ["commitment_id"], :name => "index_commitments_on_commitment_id"
  add_index "commitments", ["committed_user_id", "commitment_id"], :name => "index_commitments_on_committed_user_id_and_commitment_id", :unique => true
  add_index "commitments", ["committed_user_id"], :name => "index_commitments_on_committed_user_id"

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

  create_table "goals", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "impressions", :force => true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], :name => "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], :name => "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], :name => "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], :name => "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], :name => "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], :name => "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], :name => "impressionable_type_message_index"
  add_index "impressions", ["user_id"], :name => "index_impressions_on_user_id"

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.boolean  "is_read"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "messages", ["receiver_id"], :name => "index_messages_on_receiver_id"
  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"

  create_table "organization_users", :id => false, :force => true do |t|
    t.boolean "is_admin",        :default => false
    t.integer "user_id"
    t.integer "organization_id"
  end

  add_index "organization_users", ["organization_id", "user_id"], :name => "index_organization_users_on_organization_id_and_user_id"
  add_index "organization_users", ["user_id", "organization_id"], :name => "index_organization_users_on_user_id_and_organization_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "organizations", ["name"], :name => "index_organizations_on_name"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "desc"
    t.string   "img_url"
    t.string   "video_url"
    t.datetime "begins_on"
    t.datetime "ends_on"
    t.integer  "price"
    t.boolean  "published",         :default => false
    t.datetime "published_at"
    t.integer  "user_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "impressions_count", :default => 0
    t.datetime "last_touched"
    t.string   "state"
    t.integer  "credits",           :default => 0
    t.integer  "expected_time",     :default => 0
    t.integer  "actual_time",       :default => 0
    t.integer  "duration",          :default => 0
    t.text     "info"
    t.text     "baseline"
    t.text     "plan_do"
    t.text     "post_test"
    t.text     "wrap_up"
    t.integer  "organization_id"
    t.integer  "goal_id"
    t.string   "registration_url"
  end

  create_table "posts_specialities", :id => false, :force => true do |t|
    t.integer "post_id"
    t.integer "speciality_id"
  end

  add_index "posts_specialities", ["post_id", "speciality_id"], :name => "index_posts_specialities_on_post_id_and_speciality_id"
  add_index "posts_specialities", ["speciality_id", "post_id"], :name => "index_posts_specialities_on_speciality_id_and_post_id"

  create_table "specialities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "specialities_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "speciality_id"
  end

  add_index "specialities_users", ["speciality_id", "user_id"], :name => "index_specialities_users_on_speciality_id_and_user_id"
  add_index "specialities_users", ["user_id", "speciality_id"], :name => "index_specialities_users_on_user_id_and_speciality_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "name",                   :default => "",    :null => false
    t.string   "state",                  :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "terms",                  :default => false
    t.boolean  "admin"
    t.datetime "rejected_at"
    t.boolean  "deleted",                :default => false
    t.integer  "credits",                :default => 0
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "credit_hours",           :default => 1
    t.string   "stripe_recipient_id"
    t.boolean  "stripe_verified",        :default => false
    t.string   "stripe_customer_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false, :null => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], :name => "fk_one_vote_per_user_per_entity", :unique => true
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
