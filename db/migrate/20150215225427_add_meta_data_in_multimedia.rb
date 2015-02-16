class AddMetaDataInMultimedia < ActiveRecord::Migration
  def change
    add_column :multimedia, :metadata, :hstore
    add_index  :multimedia, :metadata, using: 'gin'
  end
end
