child :@block, root: :response do
  extends 'api/v1/blocks/base'
  child :teller do
    extends 'api/v1/guests/base'
  end
  child :blockable, if: lambda {|blockable| blockable.is_a?(Story) } do
    extends 'api/v1/stories/base'
  end
end