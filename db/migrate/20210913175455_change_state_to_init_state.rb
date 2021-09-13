class ChangeStateToInitState < ActiveRecord::Migration[6.1]
  def change
    rename_column :battle_statuses, :state, :init_state
  end
end
