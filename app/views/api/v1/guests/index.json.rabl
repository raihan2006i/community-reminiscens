child :@guests, root: :response do
  extends 'api/v1/guests/base'
end
node :pagination do
  pagination_information(@guests)
end

