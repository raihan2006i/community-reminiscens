class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :title, limit: 50, default: ''
      t.text :comment
      t.references :commentable, polymorphic: true
      t.references :person
      t.string :role, default: 'comments'
      t.timestamps
    end

    add_index :comments, [ :commentable_id, :commentable_type ]
    add_index :comments, :person_id
  end

  def self.down
    drop_table :comments
  end
end
