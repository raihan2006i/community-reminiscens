ActiveAdmin.register Attachment do
  belongs_to :story, polymorphic: true
end