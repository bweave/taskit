class AddPositionToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :position, :integer, unsigned: true
  end
end
