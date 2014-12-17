class CreateMultimedia < ActiveRecord::Migration
  def change
    create_table :multimedia do |t|
      t.string :url
      t.string :type
      t.string :source

      t.timestamps
    end
    add_attachment :multimedia, :media
  end
end
