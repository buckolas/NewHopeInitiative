class CreateChildPhotos < ActiveRecord::Migration
  def change
    create_table :child_photos do |t|
      t.string :image
      t.references :kibera_child
      t.timestamps
    end
    
    add_index :child_photos, :kibera_child_id
  end
end
