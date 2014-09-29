class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :creator_id
      t.integer :manager_id

      t.timestamps
    end

    add_index :groups, :creator_id
    add_index :groups, :manager_id
  end
end
