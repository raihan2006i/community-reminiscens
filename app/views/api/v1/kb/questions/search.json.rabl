child :@questions, root: :response do
  extends 'api/v1/kb/questions/base'

  child :theme do
    extends 'api/v1/themes/base'
  end
end
node :pagination do
  pagination_information(@questions)
end
