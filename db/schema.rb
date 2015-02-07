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

ActiveRecord::Schema.define(version: 20150204172557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
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

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "attachments", force: true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.integer  "creator_id"
    t.string   "creator_type"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree
  add_index "attachments", ["creator_id", "creator_type"], name: "index_attachments_on_creator_id_and_creator_type", using: :btree

  create_table "blocks", force: true do |t|
    t.integer  "slot_id"
    t.integer  "blockable_id"
    t.string   "blockable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.string   "creator_type"
  end

  add_index "blocks", ["blockable_id", "blockable_type"], name: "index_blocks_on_blockable_id_and_blockable_type", using: :btree
  add_index "blocks", ["creator_id", "creator_type"], name: "index_blocks_on_creator_id_and_creator_type", using: :btree

  create_table "blocks_multimedia", id: false, force: true do |t|
    t.integer "block_id"
    t.integer "multimedia_id"
  end

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commenter_id"
    t.string   "commenter_type"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["commenter_id", "commenter_type"], name: "index_comments_on_commenter_id_and_commenter_type", using: :btree

  create_table "context_translations", force: true do |t|
    t.integer  "context_id"
    t.string   "locale",     null: false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "context_translations", ["context_id"], name: "index_context_translations_on_context_id", using: :btree
  add_index "context_translations", ["locale"], name: "index_context_translations_on_locale", using: :btree

  create_table "contexts", force: true do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.string   "source",       default: "contributed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contexts", ["creator_id", "creator_type"], name: "index_contexts_on_creator_id_and_creator_type", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "manager_id"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["creator_id", "creator_type"], name: "index_groups_on_creator_id_and_creator_type", using: :btree
  add_index "groups", ["manager_id"], name: "index_groups_on_manager_id", using: :btree

  create_table "multimedia", force: true do |t|
    t.string   "url"
    t.string   "type"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.date     "birthday"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "phone"
    t.string   "mobile"
    t.integer  "user_id",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id",   default: 0
  end

  add_index "people", ["group_id"], name: "index_people_on_group_id", using: :btree
  add_index "people", ["user_id"], name: "index_people_on_user_id", using: :btree

  create_table "people_roles", id: false, force: true do |t|
    t.integer "person_id"
    t.integer "role_id"
  end

  add_index "people_roles", ["person_id", "role_id"], name: "index_people_roles_on_person_id_and_role_id", using: :btree

  create_table "question_translations", force: true do |t|
    t.integer  "question_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content"
  end

  add_index "question_translations", ["locale"], name: "index_question_translations_on_locale", using: :btree
  add_index "question_translations", ["question_id"], name: "index_question_translations_on_question_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "content"
    t.string   "source",       default: "contributed"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "theme_id",     default: 0
    t.string   "title"
    t.boolean  "trained",      default: false
  end

  add_index "questions", ["creator_id", "creator_type"], name: "index_questions_on_creator_id_and_creator_type", using: :btree
  add_index "questions", ["theme_id"], name: "index_questions_on_theme_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "session_histories", force: true do |t|
    t.integer  "session_id"
    t.integer  "slot_id"
    t.integer  "block_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "status",       default: "not_started"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "sessions", ["creator_id", "creator_type"], name: "index_sessions_on_creator_id_and_creator_type", using: :btree

  create_table "slots", force: true do |t|
    t.integer  "session_id"
    t.string   "title"
    t.integer  "duration"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "teller_id"
  end

  add_index "slots", ["creator_id", "creator_type"], name: "index_slots_on_creator_id_and_creator_type", using: :btree
  add_index "slots", ["teller_id"], name: "index_slots_on_teller_id", using: :btree

  create_table "stories", force: true do |t|
    t.integer  "teller_id"
    t.integer  "theme_id"
    t.integer  "context_id"
    t.date     "telling_date"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "stories", ["context_id"], name: "index_stories_on_context_id", using: :btree
  add_index "stories", ["creator_id", "creator_type"], name: "index_stories_on_creator_id_and_creator_type", using: :btree
  add_index "stories", ["teller_id"], name: "index_stories_on_teller_id", using: :btree
  add_index "stories", ["theme_id"], name: "index_stories_on_theme_id", using: :btree

  create_table "story_fragments", force: true do |t|
    t.text     "content"
    t.integer  "story_id"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "story_fragments", ["creator_id", "creator_type"], name: "index_story_fragments_on_creator_id_and_creator_type", using: :btree
  add_index "story_fragments", ["story_id"], name: "index_story_fragments_on_story_id", using: :btree

  create_table "theme_translations", force: true do |t|
    t.integer  "theme_id"
    t.string   "locale",     null: false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "theme_translations", ["locale"], name: "index_theme_translations_on_locale", using: :btree
  add_index "theme_translations", ["theme_id"], name: "index_theme_translations_on_theme_id", using: :btree

  create_table "themes", force: true do |t|
    t.string   "name"
    t.integer  "start_age"
    t.integer  "end_age"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.string   "source",       default: "contributed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "themes", ["creator_id", "creator_type"], name: "index_themes_on_creator_id_and_creator_type", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
