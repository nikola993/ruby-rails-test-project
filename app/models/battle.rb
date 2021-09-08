class Battle < ApplicationRecord
  has_many :armies

  enum status: %i[created in_progress paused completed]

  validates :status,
            presence: true,
            numericality: { only_integer: true, in: (0..2) }

  validates :battle_id,
            presence: true,
            uniqueness: true

  after_initialize :init

  def init
    self.status = 0
  end
end
