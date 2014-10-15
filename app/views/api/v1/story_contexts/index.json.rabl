child :@story_contexts, root: :response do
  extends 'api/v1/story_contexts/base'
end
node :pagination do
  pagination_information(@story_contexts)
end

