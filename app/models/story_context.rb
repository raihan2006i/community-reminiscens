class StoryContext < ActiveRecord::Base
  # Start external modules declaration

  # End external modules declaration

  # Start constants declaration

  SOURCES = %w(predefined contributed)

  # End constants declaration

  # Start relations declaration

  belongs_to :creator, polymorphic: true
  has_many :stories

  # End relations declaration

  # Start validations declaration

  validates :name, presence: true

  # End validations declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order

  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order

  # End class method declaration
end
