class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :manager_id
      t.references :creator, polymorphic: true

      t.timestamps
    end

    add_index :groups, [ :creator_id, :creator_type ]
    add_index :groups, :manager_id
  end
end
