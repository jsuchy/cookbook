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

ActiveRecord::Schema.define(:version => 17) do

  create_table "ingredients", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "order_of"
    t.float    "quantity"
    t.string   "uom"
    t.string   "ingredient"
    t.string   "instruction"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "recipes", :force => true do |t|
    t.string   "title"
    t.integer  "bake_temperature",  :default => 350
    t.integer  "prep_time",         :default => 0
    t.integer  "cook_time_hours",   :default => 0
    t.integer  "cook_time_minutes"
    t.text     "preparation"
    t.string   "yield"
    t.string   "source"
    t.string   "image_url"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
