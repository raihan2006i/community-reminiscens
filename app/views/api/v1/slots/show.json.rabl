child :@slot, root: :response do
  extends 'api/v1/slots/base'
  child :teller do
    extends 'api/v1/guests/base'
  end
  child :blocks do
    extends 'api/v1/blocks/base'
  end
end