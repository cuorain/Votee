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

ActiveRecord::Schema.define(version: 2020_07_23_022153) do

  create_table "choices", force: :cascade do |t|
    t.string "answer"
    t.integer "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_choices_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "question"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_surveys_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "sex", default: "0"
    t.date "birthday"
    t.integer "prefecture_code"
    t.string "image", default: "public/user_images/default_image.jpg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "survey_id"
    t.integer "choice_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choice_id"], name: "index_votes_on_choice_id"
    t.index ["survey_id"], name: "index_votes_on_survey_id"
    t.index ["user_id", "survey_id"], name: "index_votes_on_user_id_and_survey_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  create_table "votes_choices", force: :cascade do |t|
    t.integer "vote_id"
    t.integer "choice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
