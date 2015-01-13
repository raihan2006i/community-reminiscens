child :@sessions, root: :response do
  extends 'api/v1/sessions/base'
end
node :pagination do
  pagination_information(@sessions)
end

