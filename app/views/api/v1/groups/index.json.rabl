child :@groups, root: :response do
  extends 'api/v1/groups/base'
  child :manager do
    extends 'api/v1/caregivers/base'
  end
end
node :pagination do
  pagination_information(@groups)
end

