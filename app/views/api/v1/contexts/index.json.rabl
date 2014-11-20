child :@contexts, root: :response do
  extends 'api/v1/contexts/base'
end
node :pagination do
  pagination_information(@contexts)
end

