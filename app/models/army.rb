class Army < ApplicationRecord
  belongs_to :battle

  validates :name,
            presence: true,
            uniqueness: true

  validates :units,
            numericality: { greater_than_or_equal_to: 80, less_than_or_equal_to: 100 },
            presence: true

  validates :attack_strategy,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2 },
            presence: true

  enum attack_strategy: %i[random strongest weakest]

  before_create :init_values

  def init_values
    battle_status = BattleStatus.find(battle_id)
    battle_status.init_state.push(self).to_json
    battle_status.save
  end
end
