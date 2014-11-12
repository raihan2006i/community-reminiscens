class Guest < Person
  # Start external modules declaration
  #
  # Remove this line and start writing your code here
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
  # A Guest is belongs to a +Group+ object
  belongs_to :group, inverse_of: :guests
  #
  # End relations declaration

  # Start validations declaration
  # Please try to maintain alphabetical order
  #
  validates :group, presence: true
  #
  # End validations declaration

  # Start callbacks declaration
  # Please try to maintain alphabetical order
  #
  after_commit :assign_role, on: :create
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
  default_scope { with_role(ROLE_GUEST) }
  #
  # End class method declaration

  # Protected methods
  # Please try to maintain alphabetical order
  protected
  # Remove this line and start writing your code here
  #
  # End protected methods

  # Private methods
  # Please try to maintain alphabetical order
  #
  private
  def assign_role
    add_role ROLE_GUEST
  end
  #
  # End private methods
end