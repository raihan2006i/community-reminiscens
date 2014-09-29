class Group < ActiveRecord::Base
  # Start external modules declaration

  # End external modules declaration

  # Start constants declaration

  # End constants declaration

  # Start relations declaration

  belongs_to :creator, class_name: 'Person', foreign_key: 'creator_id'
  belongs_to :manager, class_name: 'Person', foreign_key: 'manager_id'
  has_many :persons

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
