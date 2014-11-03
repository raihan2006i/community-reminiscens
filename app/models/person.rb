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

  # A Guest is belongs to a +Group+ object
  belongs_to :group, inverse_of: :guests

  # A Caregiver is belongs to a +User+ object
  # This +User+ object is for sign-in in the system
  belongs_to :user, inverse_of: :person

  # has_many :created_groups, class_name: 'Group', foreign_key: 'creator_id'
  # has_many :created_stories, class_name: 'Story', foreign_key: 'creator_id'
  # has_many :manageable_groups, class_name: 'Group', foreign_key: 'manager_id'
  # has_many :telling_stories, class_name: 'Story', foreign_key: 'teller_id'
  #
  # End relations declaration

  # Start validations declaration
  # Please try to maintain alphabetical order
  #
  validates :first_name, :last_name, presence: true
  validate :validator_group
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
  # Returns true if the record has caregiver +Role+, otherwise returns false
  def is_caregiver?
    has_role? :caregiver
  end

  # Returns true if the record has guest +Role+, otherwise returns false
  def is_guest?
    has_role? :guest
  end
  #
  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order
  #
  # Create a +Person+ record with caregiver role for given +attributes+ and +user_attributes+
  # If given +attributes+ are not valid record will not be stored in database
  # Returns a +Person+ record
  def self.create_caregiver(attributes, user_attributes)
    user = User.new(user_attributes)
    caregiver = new(attributes)
    if caregiver.valid? && user.valid?
      user.save
      caregiver.user = user
      caregiver.save
      caregiver.add_role ROLE_CAREGIVER
    else
      user.errors.messages.each do |key, values|
        values.each do |value|
          caregiver.errors.add(key, value)
        end
      end
    end
    p caregiver.errors.messages
    caregiver
  end

  # Create a +Person+ record with guest role for given +attributes+
  # If given +attributes+ are not valid record will not be stored in database
  # Returns a +Person+ record
  def self.create_guest(attributes)
    guest = new(attributes)
    if guest.valid?
      guest.save
      guest.add_role ROLE_GUEST
    end
    guest
  end
  #
  # End class method declaration

  # Protected methods
  # Please try to maintain alphabetical order
  protected
  #

  # This method must be registered by the rails validate class method
  # To check whether a group can be assigned to the +person+
  # If +person+ is not a guest then add :not_a_guest error on :base
  def validator_group
    if group.present? && !is_guest?
      errors.add(:base, I18n.t(:not_a_guest, scope: [:activerecord, :errors]))
    end
  end
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
