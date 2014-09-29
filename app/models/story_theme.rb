class StoryTheme < ActiveRecord::Base
  # Start external modules declaration

  # End external modules declaration

  # Start constants declaration

  # End constants declaration

  # Start relations declaration

  belongs_to :creator, class_name: 'Person', foreign_key: 'creator_id'
  has_many :stories

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
