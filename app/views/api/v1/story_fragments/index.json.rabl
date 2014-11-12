child :@story_fragments, root: :response do
  extends 'api/v1/story_fragments/base'
  # child :creator, if: lambda { |story_fragment| story_fragment.creator.present? && story_fragment.creator.is_caregiver? } do
  #   extends 'api/v1/caregivers/base'
  # end
end
node :pagination do
  pagination_information(@story_fragments)
end

