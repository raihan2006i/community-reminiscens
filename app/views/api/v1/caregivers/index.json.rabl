child :@caregivers, root: :response do
  extends 'api/v1/caregivers/base'
  node(:email) { |caregiver| caregiver.try(:user).try(:email) }
end
node :pagination do
  pagination_information(@caregivers)
end

