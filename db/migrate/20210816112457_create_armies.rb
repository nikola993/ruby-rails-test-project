class CreateArmies < ActiveRecord::Migration[6.1]
  def change
    create_table :armies do |t|
      t.references :battle, null: false, foreign_key: true
      t.string :name, null: false, unique: true
      t.integer :units, null: false
      t.integer :attack_strategy, null: false

      t.timestamps
    end
  end
end
