class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.references :project, foreign_key: true, index: true
      t.string :name

      t.timestamps
    end
  end
end
