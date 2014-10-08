ActiveAdmin.register StoryContext do
  menu priority: 3, url: -> { admin_story_contexts_path(locale: I18n.locale) }
  permit_params :name, :source, translations_attributes: [:id, :locale, :name, :_destroy]

  filter :name
  filter :source, as: :select, collection: StoryContext::SOURCES

  controller do
    def create
      @story_context = StoryContext.new permitted_params[:story_context]
      @story_context.creator = current_admin_user
      create!
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :source, as: :select, collection: StoryContext::SOURCES
    end
    f.translated_inputs "Translated fields", switch_locale: true do |t|
      t.input :name
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :source
    column :created_at
    column :updated_at
    column :creator
    translation_status
    actions defaults: false do |story_context|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), admin_story_context_path(story_context, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('active_admin.edit'), edit_admin_story_context_path(story_context, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('active_admin.delete'), admin_story_context_path(story_context, locale: I18n.locale), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), class: 'member_link view_link'
      links
    end
  end
end
