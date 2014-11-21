class Attachment < ActiveRecord::Base
  # Start external modules declaration
  #
  has_attached_file :media
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
  belongs_to :attachable, polymorphic: true
  #
  # End relations declaration

  # Start validations declaration
  # Please try to maintain alphabetical order
  #
  do_not_validate_attachment_file_type :media
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
  def content_type
    media_content_type
  end

  def file_size
    media_file_size
  end

  def file_name
    media_file_name
  end

  def url(*args)
    media.url(*args)
  end
  #
  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order
  #
  # Remove this line and start writing your code here
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
