child :@story_themes, root: :response do
  extends 'api/v1/story_themes/base'
end
node :pagination do
  pagination_information(@story_themes)
end

