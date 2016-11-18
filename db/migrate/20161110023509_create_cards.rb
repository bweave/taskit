class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.references :list, foreign_key: true, index: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
