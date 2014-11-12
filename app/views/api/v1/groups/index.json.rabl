child :@groups, root: :response do
  extends 'api/v1/groups/base'
end
node :pagination do
  pagination_information(@groups)
end

