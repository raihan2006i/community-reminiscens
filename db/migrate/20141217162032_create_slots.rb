class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :session_id
      t.string :title
      t.integer :duration
      t.references :creator, polymorphic: true

      t.timestamps
    end
    add_index :slots, [:creator_id, :creator_type]
  end
end
