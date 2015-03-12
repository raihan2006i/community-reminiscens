child :@story, root: :response do
  extends 'api/v1/stories/base'
  child :context do
    extends 'api/v1/contexts/base'
  end
  child :theme do
    extends 'api/v1/themes/base'
  end
  child :teller do
    extends 'api/v1/guests/base'
  end
end