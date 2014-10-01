ActiveAdmin.register StoryContext do
  permit_params :name

  filter :name
  filter :source, as: :select, collection: StoryContext::SOURCES

  controller do
    def create
      @story_context = StoryContext.new permitted_params[:story_context]
      @story_context.creator = current_admin_user
      create!
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :source, as: :select, collection: StoryContext::SOURCES
    end
    f.actions
  end
end
