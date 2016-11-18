class Card < ApplicationRecord
  belongs_to :list

  before_create :set_position

  private
    def set_position
      self.position ||= 9999
    end
end
