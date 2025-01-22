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

ActiveRecord::Schema[7.2].define(version: 2025_01_21_214610) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.string "sources"
    t.integer "original_article_id"
    t.integer "category_id"
    t.string "image"
    t.float "sentiment_score", default: 0.0
    t.integer "event_id"
    t.string "location"
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["original_article_id"], name: "index_articles_on_original_article_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "position"
  end

  create_table "categories_locations", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "location_id", null: false
    t.index ["category_id", "location_id"], name: "index_categories_locations_on_category_id_and_location_id", unique: true
    t.index ["category_id"], name: "index_categories_locations_on_category_id"
    t.index ["location_id"], name: "index_categories_locations_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
  end

  create_table "original_articles", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.integer "event_id", null: false
    t.float "relevance_score", default: 0.0
    t.string "source"
    t.string "url", null: false
    t.string "location"
  end

  create_table "prompts", force: :cascade do |t|
    t.text "text", null: false
    t.float "sentiment", default: 0.0, null: false
    t.float "usage_count", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["text"], name: "index_prompts_on_text"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id"
  end

  create_table "sub_categories_locations", force: :cascade do |t|
    t.bigint "sub_category_id", null: false
    t.bigint "location_id", null: false
    t.index ["location_id"], name: "index_sub_categories_locations_on_location_id"
    t.index ["sub_category_id", "location_id"], name: "idx_on_sub_category_id_location_id_1ffeeab07b", unique: true
    t.index ["sub_category_id"], name: "index_sub_categories_locations_on_sub_category_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "original_articles"
  add_foreign_key "categories_locations", "categories"
  add_foreign_key "categories_locations", "locations"
  add_foreign_key "sub_categories", "categories"
  add_foreign_key "sub_categories_locations", "locations"
  add_foreign_key "sub_categories_locations", "sub_categories"
end
