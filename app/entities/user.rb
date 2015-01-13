class User < ActiveRecord::Base
  # Start external modules declaration
  #
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
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
  has_one :caregiver, inverse_of: :user
  #
  # End relations declaration

  # Start validations declaration
  # Please try to maintain alphabetical order
  #
  validates :authentication_token, presence: true
  #
  # End validations declaration

  # Start callbacks declaration
  # Please try to maintain alphabetical order
  #
  # before validating user assign authentication token if authentication token is blank?
  before_validation :assign_authentication_token, if: 'authentication_token.blank?'

  # before saving user record re assign authentication token if user password is changed?
  before_save :assign_authentication_token, if: :encrypted_password_changed?
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
  # Assigns a unique authentication token
  # if authentication token is null? or blank?
  # then assign a unique token
  def assign_authentication_token
    self.authentication_token = generate_authentication_token
  end

  # Generates and returns a unique token
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless self.class.exists?(authentication_token: token)
    end
  end
  #
  # End private methods
end
