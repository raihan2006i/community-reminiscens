ActiveAdmin.register Guest do
  filter :first_name
  filter :last_name
  filter :city
  filter :country, as: :select, collection: ::ActionView::Helpers::FormOptionsHelper::COUNTRIES

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :first_name, required: true
      f.input :last_name, required: true
      f.input :title
      f.input :birthday, as: :datepicker
      f.input :address
      f.input :city
      f.input :country
      f.input :phone
      f.input :mobile
      f.input :group
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :group
    column :created_at
    actions
  end

  menu parent: 'Settings', priority: 7
  permit_params :first_name, :last_name, :title, :birthday, :address, :city, :country, :phone, :mobile, :group_id

  show do
    panel I18n.t('active_admin.details', model: I18n.t('activerecord.model.guest')) do
      attributes_table_for resource do
        row :id
        row :title
        row :first_name
        row :last_name
        row :email
        row :address
        row :city
        row :country
        row :phone
        row :mobile
        row :created_at
      end
    end
  end
end