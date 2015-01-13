child :@slots, root: :response do
  extends 'api/v1/slots/base'
end
node :pagination do
  pagination_information(@slots)
end