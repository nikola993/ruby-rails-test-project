# frozen_string_literal: true

# Battle object
class BattleService
  def initialize(battle)
    @battle = battle
    @status_logger = BattleStatusService.new(battle.id)
  end

  def start_battle
    return { error: 'start error', message: 'At least 3 armies are required' } unless @battle.armies.size >= 3

    battle_status = Battle.statuses[@battle.status]
    return restart if [1, 3].include?(battle_status)

    @battle.update_attribute(:status, 1)
    @main_battle_thread = Thread.new { start }
  end

  private

  def start
    armies = []
    @battle.armies.each do |army|
      armies.push(ArmyService.new(army, @battle, @status_logger))
    end

    armies.each do |army|
      army.armies = armies
      Thread.new { army.trigger_attack }
    end
  end

  def restart
    @main_battle_thread.&:kill
    @status_logger.reset_logs
    @main_battle_thread = Thread.new { start }
  end
end
