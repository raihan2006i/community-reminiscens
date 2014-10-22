class Story < ActiveRecord::Base
  # Start external modules declaration
  #
  acts_as_commentable
  #
  # End external modules declaration

  # Start attributes reader/writer declaration
  # Please try to maintain alphabetical order
  #
  # Remove this line and start writing your code here
  #
  # End attributes reader/writer declaration

  # Start constants declaration
  # Please try to maintain alphabetical order
  #
  # Remove this line and start writing your code here
  #
  # End constants declaration

  # Start relations declaration
  # Please try to maintain alphabetical order
  #
  belongs_to :creator, polymorphic: true
  belongs_to :story_context
  belongs_to :story_theme
  belongs_to :teller, class_name: 'Person', foreign_key: 'teller_id'
  #
  # End relations declaration

  # Start validations declaration
  # Please try to maintain alphabetical order
  #
  # Remove this line and start writing your code here
  #
  # End validations declaration

  # Start callbacks declaration
  # Please try to maintain alphabetical order
  #
  # Remove this line and start writing your code here
  #
  # End callbacks declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order
  #
  # Remove this line and start writing your code here
  #
  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order
  #
  # Remove this line and start writing your code here
  #
  # End class method declaration

  # Private methods
  # Please try to maintain alphabetical order
  #
  private
  # Remove this line and start writing your code here
  #
  # End private methods
end
