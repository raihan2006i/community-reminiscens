class Caregiver < Person
  # Start external modules declaration
  #
  # Remove this line and start writing your code here
  #
  # End external modules declaration

  # Start attributes reader/writer declaration
  # Please try to maintain alphabetical order
  #
  delegate  :email, :email=,
            :password, :password=,
            :password_confirmation, :password_confirmation=,
            :authentication_token,
            :sign_in_count,
            :current_sign_in_at,
            :last_sign_in_at,
            :current_sign_in_ip,
            :last_sign_in_ip,
            to: :user, :prefix => false, :allow_nil => true
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
  # A Caregiver is belongs to a +User+ object
  # This +User+ object is for sign-in in the system
  belongs_to :user, inverse_of: :caregiver, dependent: :destroy
  has_many :stories, as: :creator
  has_many :comments, as: :commenter
  has_many :questions, as: :creator
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
  after_commit :assign_role, on: :create
  after_save :save_user
  #
  # End callbacks declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order
  #

  # Start instance method declaration
  # Please try to maintain alphabetical order
  #
  def errors
    user.errors.messages.each do |key, values|
      values.each do |value|
        super.add(key, value)
      end
    end if user
    super
  end

  def initialize(attributes = nil, options = {})
    super(attributes, options) do
      build_user(attributes.slice(:email, :password, :password_confirmation)) if !user && !!attributes
    end
  end

  def valid?(context = nil)
    context ||= (new_record? ? :create : :update)
    errors.clear
    valid = super(context)
    user.valid?(context) && valid
  end
  #
  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order
  #
  default_scope { with_role(ROLE_CAREGIVER) }

  def self.authorize(email, password)
    caregiver = joins(:user).where(users: { email: email}).first
    (caregiver && caregiver.user && caregiver.user.valid_password?(password)) ? caregiver : nil
  end

  def self.authorize!(email, password)
    caregiver = joins(:user).where(users: { email: email}).first!
    (caregiver && caregiver.user && caregiver.user.valid_password?(password)) ? caregiver : (raise ActiveRecord::RecordNotFound)
  end

  def self.as_options
    pluck("concat(#{table_name}.first_name, ' ', #{table_name}.last_name), #{table_name}.id")
  end
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
    add_role ROLE_CAREGIVER
  end

  def save_user
    user.save if user && user.changed?
  end
  #
  # End private methods
end
