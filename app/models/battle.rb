class Battle < ApplicationRecord
  has_many :armies
  has_one :battle_status

  enum status: %i[created in_progress paused completed]

  validates :status,
            presence: true,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2 }

  validates :battle_id,
            presence: true,
            uniqueness: true

  before_save :init_values

  def init_values
    self.status = 0 unless status
  end
end
