child :@blocks, root: :response do
  extends 'api/v1/blocks/base'
end
node :pagination do
  pagination_information(@blocks)
end