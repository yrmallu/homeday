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

ActiveRecord::Schema.define(version: 20181010160725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "btree_gist"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "properties", force: true do |t|
    t.string  "offer_type"
    t.string  "property_type"
    t.string  "zip_code",                                   null: false
    t.string  "city",                                       null: false
    t.string  "street"
    t.string  "house_number"
    t.decimal "lng",               precision: 11, scale: 8
    t.decimal "lat",               precision: 11, scale: 8
    t.integer "construction_year"
    t.decimal "number_of_rooms",   precision: 15, scale: 2
    t.string  "currency"
    t.decimal "price",             precision: 15, scale: 2
  end

  add_index "properties", ["offer_type", "property_type", "lng", "lat"], name: "index_properties_on_offer_and_property_type_and_ll", using: :gist

end