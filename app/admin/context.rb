ActiveAdmin.register Context do
  controller do
    def create
      @context = Context.new permitted_params[:context]
      @context.creator = current_admin_user
      create!
    end
  end

  filter :name
  filter :source, as: :select, collection: Context::SOURCES

  form do |f|
    f.inputs do
      f.input :name
      f.input :source, as: :select, collection: Context::SOURCES
    end
    f.translated_inputs 'Translated fields', switch_locale: true do |t|
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
    actions defaults: false do |context|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), admin_context_path(context, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('active_admin.edit'), edit_admin_context_path(context, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('active_admin.delete'), admin_context_path(context, locale: I18n.locale), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), class: 'member_link view_link'
      links
    end
  end

  menu parent: 'Settings', priority: 4, url: -> { admin_contexts_path(locale: I18n.locale) }
  permit_params :name, :source, translations_attributes: [:id, :locale, :name, :_destroy]

  show do
    panel I18n.t('active_admin.details', model: I18n.t('activerecord.model.context')) do
      attributes_table_for resource do
        row :id
        row :name
        row :creator
        row :source
        row :created_at
        row :updated_at
      end
    end
  end
end
