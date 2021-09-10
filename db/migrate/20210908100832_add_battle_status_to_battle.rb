class AddBattleStatusToBattle < ActiveRecord::Migration[6.1]
  def change
    add_reference :battle_statuses, :battle, index: true, foreign_key: true
  end
end
