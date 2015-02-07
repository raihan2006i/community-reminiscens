ActiveAdmin.register SessionHistory do

  filter :title
  filter :created_at

  index do
    selectable_column
    id_column
    column :session
    column :slot
    column :block
    column :created_at
  end

  show do
    panel 'Session History Details' do
      attributes_table_for resource do
        row :id
        row :session
        row :slot
        row :block
        row :created_at
        row :updated_at
      end
    end
  end

  menu priority: 12, url: -> { admin_session_histories_path(locale: I18n.locale) }
end