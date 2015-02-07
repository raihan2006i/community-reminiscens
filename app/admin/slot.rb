ActiveAdmin.register Slot do
  controller do
    def create
      @slot = Slot.new permitted_params[:slot]
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
  end

  menu priority: 10, url: -> { admin_slots_path(locale: I18n.locale) }
  permit_params :title, :duration, :teller_id
end