# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_02_01_103632) do
  create_table "ingredients", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_ingredients_on_name", unique: true
  end

  create_table "repertoire_ingredients", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "repertoire_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_repertoire_ingredients_on_ingredient_id"
    t.index ["repertoire_id", "ingredient_id"], name: "unique_repertoire_ingredient_index", unique: true
    t.index ["repertoire_id"], name: "index_repertoire_ingredients_on_repertoire_id"
  end

  create_table "repertoires", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "recipe_url"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "repertoire_image"
    t.index ["user_id"], name: "index_repertoires_on_user_id"
  end

  create_table "search_contents", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.bigint "repertoire_id"
    t.bigint "ingredient_id"
    t.string "origin_repertoire_name"
    t.string "repertoire_name"
    t.text "origin_ingredient_name"
    t.text "ingredient_name"
    t.string "repertoire_name_yomi"
    t.string "repertoire_name_ngram"
    t.string "ingredient_name_ngram"
    t.index ["ingredient_id"], name: "index_search_contents_on_ingredient_id"
    t.index ["repertoire_id"], name: "index_search_contents_on_repertoire_id"
    t.index ["repertoire_name", "ingredient_name"], name: "search_contents_fulltext_index", type: :fulltext
    t.index ["repertoire_name_ngram", "ingredient_name_ngram"], name: "search_contents_ngram_fulltext_index", type: :fulltext
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.string "provider"
    t.string "uid"
    t.string "name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "repertoire_ingredients", "ingredients"
  add_foreign_key "repertoire_ingredients", "repertoires"
  add_foreign_key "repertoires", "users"
end
