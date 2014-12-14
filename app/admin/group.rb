ActiveAdmin.register Group do
  controller do
    def create
      @group = Group.new permitted_params[:group]
      @group.creator = current_admin_user
      create!
    end
  end

  filter :name
  filter :manager

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :manager, collection: Caregiver.as_options
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :manager
    column :creator
    column :created_at
    column :updated_at
    actions
  end

  menu priority: 6
  permit_params :name, :manager_id

  show do
    panel 'Group Details' do
      attributes_table_for resource do
        row :id
        row :name
        row :manager
        row :creator
        row :created_at
        row :updated_at
      end
    end
  end
end