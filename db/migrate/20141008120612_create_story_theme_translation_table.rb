class CreateStoryThemeTranslationTable < ActiveRecord::Migration
  def change
    create_table :story_theme_translations do |t|
      t.integer :story_theme_id
      t.string :locale, null: false
      t.string :name

      t.timestamps
    end

    add_index :story_theme_translations, :story_theme_id
    add_index :story_theme_translations, :locale
  end
end
