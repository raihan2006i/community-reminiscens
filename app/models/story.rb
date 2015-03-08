class Story < ActiveRecord::Base
  # Start external modules declaration
  #
  acts_as_commentable
  #
  # End external modules declaration

  # Start attributes reader/writer declaration
  # Please try to maintain alphabetical order
  #
  # Will be used for both new and existing record
  attr_accessor :other_theme, :other_context
  # Will be used for only new record
  attr_accessor :fragment_contents
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
  belongs_to :context
  belongs_to :theme
  belongs_to :teller, class_name: 'Guest', foreign_key: 'teller_id'

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :story_fragments, dependent: :destroy
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :context, reject_if: proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :theme, reject_if: proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :story_fragments, allow_destroy: true
  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :comments, allow_destroy: true
  #
  # End relations declaration

  # Start validations declaration
  # Please try to maintain alphabetical order
  #
  validates :context, :theme, :teller, :telling_date, presence: true
  #
  # End validations declaration

  # Start callbacks declaration
  # Please try to maintain alphabetical order
  #
  after_create :create_story_fragments
  before_validation :prepare_nested_attributes
  #
  # End callbacks declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order
  #
  def add_story_fragment(attributes, creator)
    story_fragment = story_fragments.build(attributes)
    story_fragment.creator = creator
    story_fragment.save
    story_fragment
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
  #
  # Remove this line and start writing your code here
  #
  # End protected methods

  # Private methods
  # Please try to maintain alphabetical order
  #
  private
  # This method must be called by the rails after_create callback
  def create_story_fragments
    fragment_contents.compact.each do |content|
      add_story_fragment({content: content}, creator)
    end if fragment_contents.present? && fragment_contents.is_a?(Array)
  end

  # This method must be registered by the rails validate class method
  def prepare_nested_attributes
    if other_context.present?
      context = Context.case_insensitive_filter_by_name(other_context).first
      if context.present?
        self.context = context
      else
        self.context_attributes = {
            name: other_context,
            creator: creator,
            source: Context::SOURCE_CONTRIBUTED
        }
      end
    end

    if other_theme.present?
      theme = Theme.case_insensitive_filter_by_name(other_context).first
      if theme.present?
        self.theme = theme
      else
        self.theme_attributes =  {
            name: other_theme,
            creator: creator,
            source: Theme::SOURCE_CONTRIBUTED
        }
      end
    end
  end
  #
  # End private methods
end
