class Role < ActiveRecord::Base
  # Start external modules declaration

  scopify

  # End external modules declaration

  # Start constants declaration

  # End constants declaration

  # Start relations declaration

  has_and_belongs_to_many :people, join_table: :people_roles
  belongs_to :resource, polymorphic: true

  # End relations declaration

  # Start validations declaration

  # End validations declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order

  # End instance method declaration

  # Start class method declaration

  # End class method declaration
end
