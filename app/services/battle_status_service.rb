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

  def reset_logs
    BattleStatus.transaction do
      status = BattleStatus.where(battle_id: @battle_id).first
      status.update_attribute(:activity, '')
      status.update_attribute(:state, {}.to_json)
    end
  end

  private

  def log_activity(status, attacker, damage, target)
    attack_ditails = "[#{attacker[:units]}]#{attacker[:name]} -> (#{damage}) -> [#{target[:units]}]#{target[:name]}"
    status.update_attribute(:activity, "#{status.activity}---#{attack_ditails}")
  end
end
