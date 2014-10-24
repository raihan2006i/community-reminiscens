child :@story, root: :response do
  extends 'api/v1/stories/base'
  child :creator, if: lambda { |story| story.creator.present? && story.creator.is_caregiver? } do
    extends 'api/v1/caregivers/base'
  end
  child :story_context do
    extends 'api/v1/story_contexts/base'
  end
  child :story_theme do
    extends 'api/v1/story_themes/base'
  end
  child :teller do
    extends 'api/v1/guests/base'
  end
end