class AdminUser < ActiveRecord::Base
  # Start external modules declaration

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # End external modules declaration

  # Start constants declaration

  # End constants declaration

  # Start relations declaration

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
