class Person < ActiveRecord::Base
  # Start external modules declaration

  rolify

  # End external modules declaration

  # Start constants declaration

  AVAILABLE_ROLES = %w(guest caregiver)

  # End constants declaration

  # Start relations declaration

  belongs_to :user
  has_many :telling_stories, class_name: 'Story', foreign_key: 'teller_id'
  has_many :created_stories, class_name: 'Story', foreign_key: 'creator_id'
  has_many :manageable_groups, class_name: 'Group', foreign_key: 'manager_id'
  has_many :created_groups, class_name: 'Group', foreign_key: 'creator_id'
  # End relations declaration

  # Start validations declaration

  validates :user, presence: true, if: :is_caregiver?

  # End validations declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order
  def is_caregiver?
    has_role? :caregiver
  end

  def is_guest?
    has_role? :guest
  end

  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order

  # End class method declaration
end
