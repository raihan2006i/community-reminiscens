class Person < ActiveRecord::Base
  # Start external modules declaration

  rolify

  # End external modules declaration

  # Start constants declaration

  ROLE_GUEST = 'guest'
  ROLE_CAREGIVER = 'caregiver'
  AVAILABLE_ROLES = %W(#{ROLE_GUEST} #{ROLE_CAREGIVER})

  # End constants declaration

  # Start relations declaration

  belongs_to :user
  has_many :telling_stories, class_name: 'Story', foreign_key: 'teller_id'
  has_many :created_stories, class_name: 'Story', foreign_key: 'creator_id'
  has_many :manageable_groups, class_name: 'Group', foreign_key: 'manager_id'
  has_many :created_groups, class_name: 'Group', foreign_key: 'creator_id'
  # End relations declaration

  # Start validations declaration

  validates :first_name, :last_name, presence: true
  validates :user, presence: true, if: :is_caregiver?

  # End validations declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order

  # Returns true if the record has caregiver +Role+, otherwise returns false
  def is_caregiver?
    has_role? :caregiver
  end

  # Returns true if the record has guest +Role+, otherwise returns false
  def is_guest?
    has_role? :guest
  end

  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order

  # Create a +Person+ record with guest role for given +attributes+
  # If given +attributes+ are not valid record will not be stored in database
  # Returns a +Person+ record
  def self.create_guest(attributes)
    guest = new(attributes)
    if guest.save
      guest.add_role ROLE_GUEST
    end
    guest
  end

  # End class method declaration
end
