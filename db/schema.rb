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

ActiveRecord::Schema.define(:version => 20120501192249) do

  create_table "clicks", :force => true do |t|
    t.integer "user_id",    :null => false
    t.integer "cluster_id", :null => false
  end

  add_index "clicks", ["cluster_id"], :name => "cluster_id_clicks"
  add_index "clicks", ["user_id"], :name => "user_id_clicks"

  create_table "cluster_relation", :force => true do |t|
    t.integer "cluster_id1", :null => false
    t.integer "cluster_id2", :null => false
    t.integer "score",       :null => false
  end

  add_index "cluster_relation", ["cluster_id1"], :name => "cluster_id_cluster_relation1"
  add_index "cluster_relation", ["cluster_id2"], :name => "cluster_id_cluster_relation2"

  create_table "clusters", :force => true do |t|
    t.string   "label",      :limit => 45, :null => false
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "creates", :force => true do |t|
    t.integer "cluster_id", :null => false
    t.integer "query_id",   :null => false
  end

  add_index "creates", ["cluster_id"], :name => "cluster_id_creates"
  add_index "creates", ["query_id"], :name => "query_id_creates"

  create_table "docs", :force => true do |t|
    t.string   "title",      :limit => 400, :null => false
    t.string   "url",        :limit => 200, :null => false
    t.string   "snippet",    :limit => 200
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "docs_folders", :force => true do |t|
    t.integer "doc_id",    :null => false
    t.integer "folder_id", :null => false
  end

  add_index "docs_folders", ["doc_id"], :name => "doc_id_inside"
  add_index "docs_folders", ["folder_id"], :name => "folder_id_inside"

  create_table "enters", :force => true do |t|
    t.integer "query_id", :null => false
    t.integer "user_id",  :null => false
  end

  add_index "enters", ["query_id"], :name => "query_id_enters"
  add_index "enters", ["user_id"], :name => "user_id_enters"

  create_table "folders", :force => true do |t|
    t.string   "folder_name", :limit => 45, :null => false
    t.integer  "user_id",                   :null => false
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "folders", ["user_id"], :name => "user_id_folders"

  create_table "queries", :force => true do |t|
    t.string   "query_string", :limit => 140, :null => false
    t.integer  "country_code"
    t.integer  "enter_count"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer  "user_id"
  end

  add_index "queries", ["user_id"], :name => "fk_queries_1"

  create_table "query_relation", :force => true do |t|
    t.integer "score",     :null => false
    t.integer "query_id1", :null => false
    t.integer "query_id2", :null => false
  end

  add_index "query_relation", ["query_id1"], :name => "query_id_query_relation"
  add_index "query_relation", ["query_id2"], :name => "query_id_query_relation2"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
