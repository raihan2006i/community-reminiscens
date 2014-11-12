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
  attr_accessor :other_story_theme, :other_story_context
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
  belongs_to :story_context
  belongs_to :story_theme
  belongs_to :teller, class_name: 'Guest', foreign_key: 'teller_id'

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :story_fragments, dependent: :destroy

  accepts_nested_attributes_for :story_context, reject_if: proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :story_theme, reject_if: proc { |attributes| attributes['name'].blank? }
  #
  # End relations declaration

  # Start validations declaration
  # Please try to maintain alphabetical order
  #
  validates :story_context, :story_theme, :teller, :telling_date, presence: true
  validates :fragment_contents, presence: true, on: :create
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
    end
  end

  # This method must be registered by the rails validate class method
  def prepare_nested_attributes
    if other_story_context.present?
      story_context = StoryContext.case_insensitive_filter_by_name(other_story_context).first
      if story_context.present?
        self.story_context = story_context
      else
        self.story_context_attributes = {
            name: other_story_context,
            creator: creator,
            source: StoryContext::SOURCE_CONTRIBUTED
        }
      end
    end

    if other_story_theme.present?
      story_theme = StoryTheme.case_insensitive_filter_by_name(other_story_context).first
      if story_theme.present?
        self.story_theme = story_theme
      else
        self.story_theme_attributes =  {
            name: other_story_theme,
            creator: creator,
            source: StoryTheme::SOURCE_CONTRIBUTED
        }
      end
    end
  end
  #
  # End private methods
end
