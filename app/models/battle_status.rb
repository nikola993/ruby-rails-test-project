class BattleStatus < ApplicationRecord
  belongs_to :battle

  before_create :init_values

  def init_values
    self.state = {}
    self.activity = ''
  end
end
