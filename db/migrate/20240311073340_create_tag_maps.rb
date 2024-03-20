class CreateTagMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_maps do |t|
      t.references :post, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    #同じタグは2回保存しない
    add_index :tag_maps, [:post_id,:tag_id],unique: true
  end
end
