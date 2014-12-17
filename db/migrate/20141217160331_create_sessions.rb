class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.string :status
      t.references :creator, polymorphic: true

      t.timestamps
    end
    add_index :sessions, [:creator_id, :creator_type]
  end
end
