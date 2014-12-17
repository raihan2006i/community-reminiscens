class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.string :source, default: 'contributed'
      t.references :creator, polymorphic: true

      t.timestamps
    end
    add_index :questions, [:creator_id, :creator_type]
  end
end
