class Army < ApplicationRecord
  belongs_to :battle

  validates :name,
            presence: true,
            uniqueness: true

  validates :units,
            presence: true,
            numericality: { only_integer: true, in: (80..100) }

  validates :attack_strategy,
            presence: true,
            numericality: { only_integer: true, in: (0..2) }

  enum attack_strategy: %i[random strongest weakest]
end
