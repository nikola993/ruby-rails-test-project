class BattleStatus < ApplicationRecord
  belongs_to :battle

  before_create :init_values

  def init_values
    self.init_state = []
    self.activity = ''
  end
end
