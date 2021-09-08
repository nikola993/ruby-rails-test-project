# frozen_string_literal: true

# Army object
class ArmyService
  RELOAD_PER_UNIT = 0.01

  def initialize(name, units, attack_strategy)
    @name = name
    @units = units
    @strategy = attack_strategy
    @other_armies = []
    @armies = []
  end

  def armies=(armies)
    @armies = armies
    @other_armies = armies.reject { |army| army.name == name }
  end

  def attack
    target = find_target

    return self unless target

    damage = calclate_attack_damage
    target.receive_dmage(damage)

    BattleLogService.log_activity(self, damage, target)
    BattleLogService.log_battle_state(@armies)

    trigger_attack if @units.positive?
  end

  attr_reader :units, :name

  protected

  def receive_dmage(damage)
    @units -= damage
  end

  private

  def calclate_attack_damage
    return 0 unless calculate_attack_chance
    return 1 if @units == 1

    (@units * 0.5).floor
  end

  def calculate_attack_chance
    return true if @units <= rand(100)

    false
  end

  def find_target
    alive_armies = @other_armies.select { |army| army.units.positive? }
    case Army.attack_strategies[@strategy]
    when 0
      alive_armies[rand(alive_armies.length)]
    when 1
      alive_armies.max_by(&:units)
    when 2
      alive_armies.min_by(&:units)
    end
  end

  def trigger_attack
    sleep reload_time
    attack if @units.positive?
  end

  def reload_time
    @units * RELOAD_PER_UNIT
  end
end
