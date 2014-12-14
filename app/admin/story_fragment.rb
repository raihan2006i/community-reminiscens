ActiveAdmin.register StoryFragment do
  belongs_to :story, polymorphic: true

  filter :content
  filter :created_at

  index do
    selectable_column
    id_column
    column :content
    column :creator
    column :created_at
    column :updated_at
    actions
  end

  permit_params :content
end