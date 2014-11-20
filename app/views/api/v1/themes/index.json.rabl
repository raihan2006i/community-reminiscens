child :@themes, root: :response do
  extends 'api/v1/themes/base'
end
node :pagination do
  pagination_information(@themes)
end

