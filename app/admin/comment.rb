ActiveAdmin.register Comment do
  belongs_to :story, polymorphic: true, optional: true

  controller do
    def create
      @comment = parent.comments.new permitted_params[:comment]
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
    column :commenter
    column :created_at
    column :updated_at
    actions
  end

  menu false
  permit_params :comment

  show do
    panel I18n.t('active_admin.details', model: I18n.t('activerecord.model.comment')) do
      attributes_table_for resource do
        row :id
        row :comment
        row :commentable
        row :created_at
        row :updated_at
      end
    end
  end
end