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

ActiveRecord::Schema.define(version: 20_210_908_100_832) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'armies', force: :cascade do |t|
    t.bigint 'battle_id', null: false
    t.string 'name', null: false
    t.integer 'units', null: false
    t.integer 'attack_strategy', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['battle_id'], name: 'index_armies_on_battle_id'
  end

  create_table 'battle_statuses', force: :cascade do |t|
    t.text 'activity'
    t.json 'state'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'battle_id'
    t.index ['battle_id'], name: 'index_battle_statuses_on_battle_id'
  end

  create_table 'battles', force: :cascade do |t|
    t.integer 'status'
    t.string 'battle_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'armies', 'battles'
  add_foreign_key 'battle_statuses', 'battles'
end
