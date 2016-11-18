class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.references :user, foreign_key: true, index: true
      t.string :name

      t.timestamps
    end
  end
end
