class Battle < ApplicationRecord
  has_many :armies
  has_one :battle_statuses

  enum status: %i[created in_progress paused completed]

  validates :status,
            presence: true,
            numericality: { only_integer: true, in: (0..2) }

  validates :battle_id,
            presence: true,
            uniqueness: true
end
