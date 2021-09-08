# frozen_string_literal: true

# Battle object
class BattleService
  def self.start_battle(battle)
    unless battle.armies.size >= 3
      return json: { error: 'start battle error', message: 'At least 3 armies are required' }, code: 400
    end

    return restart(battle) if Battle.statuses[battle.status] == 1

    battle.update_attribute(:status, 1)
    Thread.new { start(battle) }

    {}
  end

  def self.finish_battle(battle)
    battle.update_attribute(:status, 4)
  end

  def self.start(battle)
    armies = []
    battle.armies.each do |army|
      armies.push(ArmyService.new(army.name, army.units, army.attack_strategy))
    end

    puts 'Start battle'
    armies.each do |army|
      army.armies = armies
      Thread.new { army.attack }
    end
  end

  def self.restart(battle)
    p battle, 'restart battle'
  end

  private_class_method :start, :restart
end
