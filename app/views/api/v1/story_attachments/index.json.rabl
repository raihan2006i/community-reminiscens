child :@attachments, root: :response do
  extends 'api/v1/story_attachments/base'
end
node :pagination do
  pagination_information(@attachments)
end

