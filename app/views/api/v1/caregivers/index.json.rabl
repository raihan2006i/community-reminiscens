child :@caregivers, root: :response do
  extends 'api/v1/caregivers/base'
end
node :pagination do
  pagination_information(@caregivers)
end

