class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :end_user_id, null: false
      t.string :title, null: false
      t.text :caption

      t.timestamps
    end
  end
end
