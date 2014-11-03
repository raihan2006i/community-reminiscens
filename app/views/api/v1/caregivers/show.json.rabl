child :@caregiver, root: :response do
  extends 'api/v1/caregivers/base'
  node(:email) { |caregiver| caregiver.try(:user).try(:email) }
end