class CreateStoryContextTranslationTable < ActiveRecord::Migration
  def change
    create_table :story_context_translations do |t|
      t.integer :story_context_id
      t.string :locale, null: false
      t.string :name

      t.timestamps
    end

    add_index :story_context_translations, :story_context_id
    add_index :story_context_translations, :locale
  end
end
