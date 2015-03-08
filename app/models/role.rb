class Role < ActiveRecord::Base
  # Start external modules declaration
  #
  scopify
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
  belongs_to :resource, polymorphic: true
  has_and_belongs_to_many :people, join_table: :people_roles
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
