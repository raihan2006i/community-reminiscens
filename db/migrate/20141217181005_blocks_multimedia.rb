class BlocksMultimedia < ActiveRecord::Migration
  def change
    create_table :blocks_multimedia, id: false do |t|
      t.integer :block_id
      t.integer :multimedia_id
    end
  end
end
