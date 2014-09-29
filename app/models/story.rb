class Story < ActiveRecord::Base
  # Start external modules declaration

  # End external modules declaration

  # Start constants declaration

  # End constants declaration

  # Start relations declaration

  belongs_to :creator, class_name: 'Person', foreign_key: 'creator_id'
  belongs_to :teller, class_name: 'Person', foreign_key: 'teller_id'
  belongs_to :story_theme
  belongs_to :story_context

  # End relations declaration

  # Start validations declaration

  # End validations declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order

  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order

  # End class method declaration
end
