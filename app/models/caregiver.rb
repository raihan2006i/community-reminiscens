class Caregiver
  # Start external modules declaration
  #
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  #
  # End external modules declaration

  # Start attributes reader/writer declaration
  # Please try to maintain alphabetical order
  #
  attr_reader :person
  attr_reader :user

  delegate :first_name, :first_name=,
           :last_name, :first_name=,
           :title, :title=,
           :birthday, :birthday=,
           :address, :address=,
           :city, :city=,
           :country, :country=,
           :phone, :phone=,
           :mobile, :mobile=,
           :id,
           :created_at,
           :updated_at,
           to: :person, prefix: false, allow_nil: false

  delegate :email, :email=,
           :password, :password=,
           :password_confirmation, :password_confirmation=,
           :authentication_token,
           :to => :user, :prefix => false, :allow_nil => false
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
  # Remove this line and start writing your code here
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
  # Remove this line and start writing your code here
  #
  # End callbacks declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order
  #
  def attributes=(attributes)
    attributes.each { |k, v| self.send("#{k}=", v) }
  end

  def errors
    person.errors.messages.each do |key, values|
      values.each do |value|
        super.add(key, value)
      end
    end
    user.errors.messages.each do |key, values|
      values.each do |value|
        super.add(key, value)
      end
    end
    super
  end

  def initialize(person, user)
    raise ArgumentError, 'Argument 0 should be an instance of Person class' unless person.is_a?(Person)
    raise ArgumentError, 'Argument 0 should be an instance of User class' unless user.is_a?(User)
    @user = user
    @person = person
    @person.user = @user
  end

  def persisted?
    @user.persisted? && @person.persisted?
  end

  def save
    Person.transaction do
      person_is_new = @person.new_record?
      @person.save
      @person.add_role Person::ROLE_CAREGIVER if person_is_new
    end
    User.transaction do
      @user.save
    end
  end

  def save!
    Person.transaction do
      person_is_new = @person.new_record?
      @person.save!
      @person.add_role Person::ROLE_CAREGIVER if person_is_new
    end
    User.transaction do
      @user.save!
    end
  end

  def update(attributes)
    attributes.delete(:password)
    attributes.delete(:password_confirmation)
    self.attributes = attributes
    save
  end

  def valid?(context = nil)
    errors.clear
    valid = super(context)
    valid = @person.valid? && valid
    @user.valid? && valid
  end
  #
  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order
  #
  def self.authorize(email, password)
    user = User.find_by(email: email)
    if user && user.valid_password?(password)
      Caregiver.new(user.person, user)
    else
      nil
    end
  end

  def self.authorize!(email, password)
    user = User.find_by!(email: email)
    if user && user.valid_password?(password)
      Caregiver.new(user.person, user)
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def self.create(attributes)
    person = Person.new
    user = User.new
    caregiver = Caregiver.new(person, user)
    caregiver.attributes = attributes
    caregiver.save
  end

  def self.find(id)
    person = Person.caregivers.find(id)
    Caregiver.new(person, person.user)
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
  # Remove this line and start writing your code here
  #
  # End private methods
end
