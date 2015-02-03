class CreateSessionHistories < ActiveRecord::Migration
  def change
    create_table :session_histories do |t|
      t.integer :session_id, index: true
      t.integer :slot_id, index: true
      t.integer :block_id, index: true

      t.timestamps
    end
  end
end
