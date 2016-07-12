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

ActiveRecord::Schema.define(version: 20160712072735) do

  create_table "actors", force: :cascade do |t|
    t.string   "first_name", limit: 30
    t.string   "last_name",  limit: 30
    t.date     "birth_date"
    t.text     "biography",  limit: 65535
    t.string   "gender",     limit: 10
    t.string   "country",    limit: 20
    t.string   "city",       limit: 20
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "appearances", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4
    t.integer  "actor_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "appearances", ["actor_id"], name: "index_appearances_on_actor_id", using: :btree
  add_index "appearances", ["movie_id"], name: "index_appearances_on_movie_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.integer  "attachable_id",      limit: 4
    t.string   "attachable_type",    limit: 255
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "attachments", ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "title",        limit: 50
    t.date     "release_date"
    t.string   "genre",        limit: 20
    t.integer  "duration",     limit: 8
    t.text     "description",  limit: 65535
    t.text     "trailer_url",  limit: 65535
    t.boolean  "featured"
    t.boolean  "approved"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "movies", ["genre"], name: "index_movies_on_genre", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.integer  "score",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "ratings", ["movie_id"], name: "index_ratings_on_movie_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "reported_reviews", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "review_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "reported_reviews", ["review_id"], name: "index_reported_reviews_on_review_id", using: :btree
  add_index "reported_reviews", ["user_id"], name: "index_reported_reviews_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "reviews", ["movie_id"], name: "index_reviews_on_movie_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 50
    t.string   "last_name",              limit: 50
    t.string   "gender",                 limit: 10
    t.date     "birth_date"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "appearances", "actors"
  add_foreign_key "appearances", "movies"
  add_foreign_key "ratings", "movies"
  add_foreign_key "ratings", "users"
  add_foreign_key "reported_reviews", "reviews"
  add_foreign_key "reported_reviews", "users"
  add_foreign_key "reviews", "movies"
  add_foreign_key "reviews", "users"
end
