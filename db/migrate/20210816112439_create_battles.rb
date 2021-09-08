class CreateBattles < ActiveRecord::Migration[6.1]
  def change
    create_table :battles do |t|
      t.integer :status
      t.string :battle_id

      t.timestamps
    end
  end
end
