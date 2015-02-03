class AddTellerIdInSlots < ActiveRecord::Migration
  def change
    add_column :slots, :teller_id, :integer
    add_index :slots, :teller_id
  end
end

