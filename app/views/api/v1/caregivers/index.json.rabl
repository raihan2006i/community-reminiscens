child :@persons, root: :response do
  extends 'api/v1/caregivers/base'
  node(:email) { |person| person.try(:user).try(:email) }
end
node :pagination do
  pagination_information(@persons)
end

