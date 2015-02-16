ActiveAdmin.register Block do
  belongs_to :slot, optional: true

  controller do
    def create
      @block = parent.blocks.new permitted_params[:block]
      @block.creator = current_admin_user
      create!
    end
  end

  filter :created_at

  form do |f|
    f.semantic_errors
    f.inputs do
      # f.input :blockable
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :blockable
    column :created_at

  end

  show do
    panel 'Block Details' do
      attributes_table_for resource do
        row :id
        row :slot_id
        row :blockable
        row :created_at
        row :updated_at
        row :creator
      end
    end
  end

  menu false
  navigation_menu :default
  permit_params :blockable

end