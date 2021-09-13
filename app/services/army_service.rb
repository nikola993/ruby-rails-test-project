# frozen_string_literal: true

require 'concurrent'

# Army object
class ArmyService
  RELOAD_PER_UNIT = 0.01

  def initialize(army, battle, status_logger)
    @id = army.id
    @strategy = army.attack_strategy
    @status_logger = status_logger
    @battle = battle
    @other_armies = battle.armies.reject { |item| item.id == army.id }
  end

  def attack
    attacker_units = nil
    @battle.armies.with_advisory_lock('attack') do
      target = find_target(@other_armies)
      return @battle.update_attribute(:status, 3) unless target

      attacker = @battle.armies.find(@id)
      attacker_units = attacker.units
      return unless attacker_units.to_i.positive?

      updating_db(attacker, target)
    end

    trigger_attack(attacker_units)
  end

  attr_reader :name

  private

  def trigger_attack(units)
    sleep units * RELOAD_PER_UNIT
    attack
  end

  def updating_db(attacker, target)
    damage = calclate_attack_damage(attacker.units)
    target.update_attribute(:units, target.units - damage)
    @status_logger.log_event(attacker, damage, target)
  end

  def calclate_attack_damage(units)
    return 0 unless calculate_attack_chance(units)
    return 1 if units == 1

    (units * 0.5).floor
  end

  def calculate_attack_chance(units)
    return true if units >= rand(100)

    false
  end

  def find_target(armies)
    alive_armies = armies.select { |army| army.units.to_i.positive? }
    case Army.attack_strategies[@strategy]
    when 0
      alive_armies[rand(alive_armies.length)]
    when 1
      alive_armies.max_by(&:units)
    when 2
      alive_armies.min_by(&:units)
    end
  end
end
