class List < ApplicationRecord
  belongs_to :project
  has_many :cards, -> {order(position: :asc)}, dependent: :destroy

  before_create :set_position

  private
    def set_position
      self.position ||= 9999
    end

end
