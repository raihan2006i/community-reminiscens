child :@session, root: :response do
  extends 'api/v1/sessions/base'
  child :slots do
    extends 'api/v1/slots/base'
    child :blocks do
      extends 'api/v1/blocks/base'
    end
  end
end