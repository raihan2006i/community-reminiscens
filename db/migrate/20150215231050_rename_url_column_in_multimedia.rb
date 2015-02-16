class RenameUrlColumnInMultimedia < ActiveRecord::Migration
  def change
    rename_column :multimedia, :url, :uri
  end
end
