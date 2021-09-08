# frozen_string_literal: true

# Logger for battle activity
class BattleLogService
  def self.log_activity(attacker, damage, target)
    template = '[%<attacker_units>s]%<attacker_id>s -> (%<damage>s) -> [%<target_units>s]%<target_id>s'
    puts format(template, attacker_units: attacker.units, attacker_id: attacker.name, damage: damage,
                          target_units: target.units, target_id: target.name)
  end

  def self.log_battle_state(armies)
    puts armies
  end
end
