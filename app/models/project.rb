class Project < ApplicationRecord
  belongs_to :user
  has_many :lists, -> {order(position: :asc)}

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
