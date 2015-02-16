class ChangeUrlColumnTypeInMultimedia < ActiveRecord::Migration
  def up
    change_column :multimedia, :url, :text
  end

  def down
    change_column :multimedia, :url, :string
  end
end
