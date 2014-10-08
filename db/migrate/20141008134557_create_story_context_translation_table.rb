class CreateStoryContextTranslationTable < ActiveRecord::Migration
  def up
    StoryContext.create_translation_table!({ name: :string }, { migrate_data: true })
  end

  def down
    StoryContext.drop_translation_table! migrate_data: true
  end
end
