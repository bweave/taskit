class AddPositionToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :position, :integer, unsigned: true
  end
end
