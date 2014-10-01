class Comment < ActiveRecord::Base
  # Start external modules declaration

  include ActsAsCommentable::Comment
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # End external modules declaration

  # Start constants declaration

  # End constants declaration

  # Start relations declaration

  belongs_to :commentable, polymorphic: true
  belongs_to :person

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
