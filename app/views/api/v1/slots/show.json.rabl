child :@slot, root: :response do
  extends 'api/v1/slots/base'
  child :blocks do
    extends 'api/v1/blocks/base'
  end
end