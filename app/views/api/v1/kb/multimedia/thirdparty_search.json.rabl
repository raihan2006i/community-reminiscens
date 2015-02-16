child :@multimedia, root: :response do
  extends 'api/v1/kb/multimedia/base'
end
node :pagination do
  pagination_information(@multimedia)
end
