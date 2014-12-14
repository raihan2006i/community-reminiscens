ActiveAdmin.register Comment do
  belongs_to :story, polymorphic: true

  controller do
    def create
      @comment = owner.comments.new permitted_params[:comment]
      @comment.commenter = current_admin_user
      create!
    end
  end

  filter :comment
  filter :created_at

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :comment
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :comment
    column :creator
    column :created_at
    column :updated_at
    actions
  end

  permit_params :comment
end