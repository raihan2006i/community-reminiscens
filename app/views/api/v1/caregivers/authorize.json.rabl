child :@caregiver, root: :response do
  extends 'api/v1/caregivers/base'
  node(:email) { @user.email }
  node(:authentication_token) { @user.authentication_token }
end