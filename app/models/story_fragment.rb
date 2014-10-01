class StoryFragment < ActiveRecord::Base
  # Start external modules declaration

  # End external modules declaration

  # Start constants declaration

  # End constants declaration

  # Start relations declaration

  belongs_to :creator, polymorphic: true
  belongs_to :story

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
