class StoryTheme < ActiveRecord::Base
  # Start external modules declaration

  # End external modules declaration

  # Start constants declaration

  # End constants declaration

  SOURCES = %w(predefined contributed)

  # Start relations declaration

  belongs_to :creator, polymorphic: true
  has_many :stories

  # End relations declaration

  # Start validations declaration

  validates :name, presence: true
  validates :start_age, :end_age, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true

  # End validations declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order

  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order

  # End class method declaration
end
