class Person < ActiveRecord::Base
  # Start external modules declaration
  #
  rolify
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
  ROLE_CAREGIVER = 'caregiver'
  ROLE_GUEST = 'guest'
  AVAILABLE_ROLES = %W(#{ROLE_GUEST} #{ROLE_CAREGIVER})
  #
  # End constants declaration

  # Start relations declaration
  # Please try to maintain alphabetical order
  #
  has_and_belongs_to_many :roles
  #
  # End relations declaration

  # Start validations declaration
  # Please try to maintain alphabetical order
  #
  validates :first_name, :last_name, presence: true
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
  def name
    [first_name, last_name].compact.join(' ')
  end
  #
  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order
  #
  # Remove this line and start writing your code here
  #
  # End class method declaration

  # Protected methods
  # Please try to maintain alphabetical order
  protected
  #
  # Remove this line and start writing your code here
  #
  # End protected methods

  # Private methods
  # Please try to maintain alphabetical order
  private
  #
  # Remove this line and start writing your code here
  #
  # End private methods
end
