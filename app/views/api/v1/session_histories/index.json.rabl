child :@session_histories, root: :response do
  extends 'api/v1/session_histories/base'
end
node :pagination do
  pagination_information(@session_histories)
end

