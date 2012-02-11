class CreateKiberaChildren < ActiveRecord::Migration
  def change
    create_table :kibera_children do |t|
      t.string :firstName
      t.string :lastName

      t.timestamps
    end
  end
end
