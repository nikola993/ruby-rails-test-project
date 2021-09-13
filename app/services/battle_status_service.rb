# frozen_string_literal: true

# Logger for battle activity
class BattleStatusService
  def initialize(battle_id)
    @battle_id = battle_id
  end

  def log_event(attacker, damage, target)
    status = BattleStatus.where(battle_id: @battle_id).first
    status.with_advisory_lock('log_activity') do
      log_activity(status, attacker, damage, target)
    end
  end

  def reset_game(battle)
    BattleStatus.transaction do
      status = BattleStatus.find(@battle_id)
      status.update_column(:activity, '')

      battle.update_column(:status, 1)

      status.init_state.each do |init_army|
        battle.armies.where(name: init_army['name']).first.update_column(:units, init_army['units'])
      end
    end
  end

  private

  def log_activity(status, attacker, damage, target)
    attack_ditails = "[#{attacker[:units]}]#{attacker[:name]} -> (#{damage}) -> [#{target[:units]}]#{target[:name]}"
    status.update_attribute(:activity, "#{status.activity}---#{attack_ditails}")
  end
end
