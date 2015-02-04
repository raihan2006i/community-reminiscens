ActiveAdmin.register Theme do
  controller do
    def create
      @theme = Theme.new permitted_params[:theme]
      @theme.creator = current_admin_user
      create!
    end
  end

  filter :name
  filter :source, as: :select, collection: Context::SOURCES

  form do |f|
    f.inputs do
      f.input :name
      f.input :start_age, as: :number
      f.input :end_age, as: :number
      f.input :source, as: :select, collection: Context::SOURCES
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
    column :creator
    column :created_at
    translation_status
    actions defaults: false do |theme|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), admin_theme_path(theme, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('active_admin.edit'), edit_admin_theme_path(theme, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('active_admin.delete'), admin_theme_path(theme, locale: I18n.locale), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), class: 'member_link view_link'
      links
    end
  end

  menu parent: 'Settings', priority: 3, url: -> { admin_themes_path(locale: I18n.locale) }
  permit_params :name, :start_age, :end_age, :source, translations_attributes: [:id, :locale, :name, :_destroy]

  show do
    panel I18n.t('active_admin.details', model: I18n.t('activerecord.model.theme')) do
      attributes_table_for resource do
        row :id
        row :name
        row :creator
        row :start_age
        row :end_age
        row :source
        row :created_at
        row :updated_at
      end
    end
  end
end
