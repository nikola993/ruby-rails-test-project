# frozen_string_literal: true

require 'concurrent'

# Army object
class ArmyService
  RELOAD_PER_UNIT = 0.01

  def initialize(army, battle, status_logger)
    @name = army.name
    @units = army.units
    @strategy = army.attack_strategy
    @status_logger = status_logger
    @battle = battle
    @other_armies = Concurrent::ThreadLocalVar.new { [] }.value
    @armies = Concurrent::ThreadLocalVar.new { [] }.value
  end

  def armies=(armies)
    @armies = armies
    @other_armies = armies.reject { |army| army.name == name }
  end

  def trigger_attack
    sleep reload_time
    attack if @units.to_i.positive?
  end

  attr_reader :units, :name, :strategy

  protected

  def receive_dmage(damage)
    @units -= damage
  end

  private

  def attack
    target = find_target
    return @battle.update_attribute(:status, 3) unless target

    damage = calclate_attack_damage
    attacker = { units: @units, name: @name }
    deffender = { units: target.units - damage, name: target.name }

    @status_logger.log_event(attacker, damage, deffender, @armies)
    target.receive_dmage(damage)
    trigger_attack if @units.to_i.positive?
  end

  def calclate_attack_damage
    return 0 unless calculate_attack_chance
    return 1 if @units == 1

    (@units * 0.5).floor
  end

  def calculate_attack_chance
    return true if @units >= rand(100)

    false
  end

  def find_target
    alive_armies = @other_armies.select { |army| army.units.to_i.positive? }
    case Army.attack_strategies[@strategy]
    when 0
      alive_armies[rand(alive_armies.length)]
    when 1
      alive_armies.max_by(&:units)
    when 2
      alive_armies.min_by(&:units)
    end
  end

  def reload_time
    @units * RELOAD_PER_UNIT
  end
end
