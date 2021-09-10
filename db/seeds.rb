# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Battle.create(
  [
    {
      id: 1,
      battle_id: SecureRandom.uuid,
      status: 2
    }
  ]
)

BattleStatus.create(
  [
    {
      battle_id: 1,
      state: {},
      activity: ''
    }
  ]
)

Army.create(
  [
    {
      battle_id: 1,
      name: 'first army',
      units: 90,
      attack_strategy: 1
    },
    {
      battle_id: 1,
      name: 'second army',
      units: 93,
      attack_strategy: 2
    },
    {
      battle_id: 1,
      name: 'third army',
      units: 92,
      attack_strategy: 0
    }
  ]
)
