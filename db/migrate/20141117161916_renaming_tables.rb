class RenamingTables < ActiveRecord::Migration
  def change
    rename_column :story_context_translations, :story_context_id, :context_id
    rename_column :story_theme_translations, :story_theme_id, :theme_id
    rename_column :stories, :story_theme_id, :theme_id
    rename_column :stories, :story_context_id, :context_id

    rename_table :story_contexts, :contexts
    rename_table :story_themes, :themes
    rename_table :story_context_translations, :context_translations
    rename_table :story_theme_translations, :theme_translations
  end
end
