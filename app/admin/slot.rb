ActiveAdmin.register Slot do
  belongs_to :session, optional: true

  controller do
    def create
      @slot = parent.slots.new permitted_params[:slot]
      @slot.creator = current_admin_user
      create!
    end
  end

  filter :title
  filter :duration
  filter :created_at
  filter :teller

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :duration
      f.input :teller
      f.input :session
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :duration
    column :teller
    column :creator
    column :created_at
    actions defaults: false do |slot|
      link_to 'Blocks', admin_slot_blocks_path(slot)
    end
  end

  menu false
  navigation_menu :default
  permit_params :title, :duration, :teller_id
end