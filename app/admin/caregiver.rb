ActiveAdmin.register Moderator do
  controller do
    def scoped_collection
      end_of_association_chain.includes(:user)
    end
  end

  filter :first_name
  filter :last_name
  filter :user_email, as: :string, label: 'Email'
  filter :city
  filter :country, as: :select, collection: ::ActionView::Helpers::FormOptionsHelper::COUNTRIES

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :first_name, required: true
      f.input :last_name, required: true
      f.input :title
      f.input :birthday
      f.input :address
      f.input :city
      f.input :country
      f.input :phone
      f.input :mobile
      f.input :email, required: true
      f.input :password, required: f.object.new_record?
      f.input :password_confirmation, required: f.object.new_record?
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email, sortable: 'users.email'
    column :created_at
    column :updated_at
    actions
  end

  menu parent: 'Settings', priority: 5
  permit_params :first_name, :last_name, :title, :birthday, :address, :city, :country, :phone, :mobile, :email, :password, :password_confirmation

  show do
    panel I18n.t('active_admin.details', model: I18n.t('activerecord.model.caregiver')) do
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
        row :updated_at
        row :current_sign_in_at
        row :last_sign_in_at
        row :current_sign_in_ip
        row :last_sign_in_ip
        row :authentication_token
      end
    end
  end
end