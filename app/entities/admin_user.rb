class AdminUser < ActiveRecord::Base
  # Start external modules declaration
  #
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
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
  def first_name
    nil
  end

  def title
    nil
  end

  def last_name
    nil
  end

  def birthday
    nil
  end

  def address
    nil
  end

  def city
    nil
  end

  def country
    nil
  end

  def phone
    nil
  end

  def mobile
    nil
  end
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
  private
  #
  # Remove this line and start writing your code here
  #
  # End private methods
end
