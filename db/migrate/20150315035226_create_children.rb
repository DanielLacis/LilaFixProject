class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :picture, null: false

      t.timestamps
    end
  end
end
