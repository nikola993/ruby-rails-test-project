class CreateBattleStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :battle_statuses do |t|
      t.text :activity
      t.json :state

      t.timestamps
    end
  end
end
