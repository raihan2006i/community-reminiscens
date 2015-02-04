ActiveAdmin.register StoryFragment do
  belongs_to :story, polymorphic: true, optional: true

  controller do
    def create
      @story_fragment = parent.story_fragments.new permitted_params[:story_fragment]
      @story_fragment.creator = current_admin_user
      create!
    end
  end

  filter :content
  filter :created_at
  filter :updated_at

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :content
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :content
    column :creator
    column :created_at
    column :updated_at
    actions
  end

  menu false
  permit_params :content

  show do
    panel I18n.t('active_admin.details', model: I18n.t('activerecord.model.story_fragment')) do
      attributes_table_for resource do
        row :id
        row :content
        row :creator
        row :created_at
        row :updated_at
      end
    end
  end
end