class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content, null: false
      t.integer :user_id, null: false
      t.integer :child_id, null: false
      t.string :picture, null: false

      t.timestamps
    end

    add_index :posts, :user_id
    add_index :posts, :child_id
  end
end
