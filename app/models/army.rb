class Army < ApplicationRecord
  belongs_to :battle

  validates :name,
            presence: true,
            uniqueness: true

  validates :units,
            numericality: { greater_than_or_equal_to: 80, less_than_or_equal_to: 100 },
            presence: true

  validates :attack_strategy,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2 },
            presence: true

  enum attack_strategy: %i[random strongest weakest]
end
