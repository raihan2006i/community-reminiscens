ActiveAdmin.register SessionHistory do
  belongs_to :session, optional: true

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

  menu false
  navigation_menu :default
end