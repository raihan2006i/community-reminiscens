child :@session_history, root: :response do
  extends 'api/v1/session_histories/base'
  child :session do
    extends 'api/v1/sessions/base'
  end
  child :slot do
    extends 'api/v1/slots/base'
  end
  child :block do
    extends 'api/v1/blocks/base'
  end
end