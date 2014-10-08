class CreateStoryThemeTranslationTable < ActiveRecord::Migration
  def up
    StoryTheme.create_translation_table!({ name: :string }, { migrate_data: true })
  end

  def down
    StoryTheme.drop_translation_table! migrate_data: true
  end
end
