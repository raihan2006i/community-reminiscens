class Group < ActiveRecord::Base
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

  belongs_to :creator, polymorphic: true

  # Manager is a +Person+ who has caregiver role
  belongs_to :manager, class_name: 'Person', foreign_key: 'manager_id'

  has_many :guests, class_name: 'Person', inverse_of: :group
  #
  # End relations declaration

  # Start validations declaration
  # Please try to maintain alphabetical order
  #
  validates :name, :manager, presence: true
  validate :validator_manager_is_caregiver
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
  #
  #
  # End class method declaration

  # Protected methods
  # Please try to maintain alphabetical order
  protected
  #

  # This method must be registered by the rails validate class method
  # To check whether manager is a caregiver
  # If manager is not a caregiver then add :not_a_caregiver error on :manager attribute
  def validator_manager_is_caregiver
    if manager.present? && !manager.is_caregiver?
      errors.add(:manager, I18n.t(:not_a_caregiver, scope: [:activerecord, :errors]))
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
