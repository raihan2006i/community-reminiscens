child :@stories, root: :response do
  extends 'api/v1/stories/base'
  child :creator, if: lambda { |story| story.creator.present? && story.creator.is_a?(Caregiver) } do
    extends 'api/v1/caregivers/base'
  end
  child :context do
    extends 'api/v1/contexts/base'
  end
  child :theme do
    extends 'api/v1/themes/base'
  end
  child :teller do
    extends 'api/v1/guests/base'
  end
end
node :pagination do
  pagination_information(@stories)
end

