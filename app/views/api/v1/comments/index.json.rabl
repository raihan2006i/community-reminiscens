child :@comments, root: :response do
  extends 'api/v1/comments/base'
end
node :pagination do
  pagination_information(@comments)
end

