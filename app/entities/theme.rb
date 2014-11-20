class Theme < ActiveRecord::Base
  # Start external modules declaration
  #
  include NameFilters
  # Translated fields with globalize and for active admin
  active_admin_translates :name
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
  SOURCE_CONTRIBUTED = 'contributed'
  SOURCE_PREDEFINED = 'predefined'
  SOURCES = %W(#{SOURCE_CONTRIBUTED} #{SOURCE_PREDEFINED})
  #
  # End constants declaration

  # Start relations declaration
  # Please try to maintain alphabetical order
  #
  belongs_to :creator, polymorphic: true
  has_many :stories
  #
  # End relations declaration

  # Start validations declaration
  # Please try to maintain alphabetical order
  #
  validates :name, presence: true
  validates :start_age, :end_age, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
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
