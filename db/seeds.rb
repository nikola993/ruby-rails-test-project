# frozen_string_literal: true

Battle.create(
  [
    {
      id: 1,
      battle_id: 'First battle',
      status: 2
    },
    {
      id: 2,
      battle_id: 'Second battle',
      status: 2
    }
  ]
)

BattleStatus.create(
  [
    {
      battle_id: 1,
      init_state: [
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
      ].to_json,
      activity: ''
    },
    {
      battle_id: 2,
      init_state: {},
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
    },
    {
      battle_id: 2,
      name: 'first army / second battle',
      units: 81,
      attack_strategy: 1
    },
    {
      battle_id: 2,
      name: 'second army / second battle',
      units: 93,
      attack_strategy: 2
    },
    {
      battle_id: 2,
      name: 'third army / second battle',
      units: 92,
      attack_strategy: 0
    },
    {
      battle_id: 2,
      name: 'fourth army / second battle',
      units: 90,
      attack_strategy: 1
    },
    {
      battle_id: 2,
      name: 'fifth army / second battle',
      units: 83,
      attack_strategy: 2
    },
    {
      battle_id: 2,
      name: 'sixth army / second battle',
      units: 98,
      attack_strategy: 0
    }
  ]
)
