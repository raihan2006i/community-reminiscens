ActiveAdmin.register Multimedia do

  filter :uri

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :uri
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :uri
    column :content, sortable: false
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel I18n.t('active_admin.details', model: I18n.t('activerecord.model.multimedia')) do
      attributes_table_for resource do
        row :id
        row :uri
        row :content
        row :created_at
        row :updated_at
      end
    end
  end
end