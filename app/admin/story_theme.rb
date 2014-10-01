ActiveAdmin.register StoryTheme do
  permit_params :name, :start_age, :end_age, :source

  filter :name
  filter :source, as: :select, collection: StoryContext::SOURCES

  controller do
    def create
      @story_theme = StoryTheme.new permitted_params[:story_theme]
      @story_theme.creator = current_admin_user
      create!
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :start_age, as: :number
      f.input :end_age, as: :number
      f.input :source, as: :select, collection: StoryContext::SOURCES
    end
    f.actions
  end
end
