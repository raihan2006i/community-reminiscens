class Multimedia < ActiveRecord::Base
  # Start external modules declaration
  #
  has_attached_file :media
  #
  # End external modules declaration

  # Start attributes reader/writer declaration
  # Please try to maintain alphabetical order
  #
  store_accessor :metadata, :title, :content, :publisher, :thumbnail_uri, :thumbnail_width, :thumbnail_height, :visible_uri, :duration, :width, :height
  #
  # End attributes reader/writer declaration

  # Start constants declaration
  # Please try to maintain alphabetical order
  #
  SOURCE_GOOGLE = 'google'
  SOURCE_APPLICATION = 'application'

  TYPE_IMAGE = 'image'
  TYPE_VIDEO = 'video'

  #
  # End constants declaration

  # Start relations declaration
  # Please try to maintain alphabetical order
  #
  has_and_belongs_to_many :blocks
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
  after_initialize :default_values
  #
  # End callbacks declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order
  #
  def uri(*args)
    super || media.url(*args)
  end
  #
  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order
  #
  self.inheritance_column = nil
  scope :images, -> { where(type: TYPE_IMAGE) }
  scope :videos, -> { where(type: TYPE_VIDEO) }
  scope :filter_by_type, ->(type) { where(type: type) }

  def self.local_search(query)
    where('(media_file_name @@ :q) or (uri @@ :q) or CAST(avals(metadata) AS text) @@ :q', q: query)
  end

  def self.thirdparty_search(query)
    Google::Search::Image.new(query: query).each {|image|
      multimedia = Multimedia.find_or_initialize_by(uri: image.uri )
      multimedia.title = image.uri
      multimedia.content = image.content
      multimedia.thumbnail_uri = image.thumbnail_uri
      multimedia.thumbnail_width = image.thumbnail_width
      multimedia.thumbnail_height = image.thumbnail_height
      multimedia.visible_uri = image.visible_uri
      multimedia.width = image.width
      multimedia.height = image.height
      multimedia.source = SOURCE_GOOGLE
      multimedia.type = TYPE_IMAGE
      multimedia.save
    }
    Google::Search::Video.new(query: query).each {|video|
      multimedia = Multimedia.find_or_initialize_by(uri: video.uri )
      multimedia.title = video.uri
      multimedia.content = video.content
      multimedia.publisher = video.publisher
      multimedia.thumbnail_uri = video.thumbnail_uri
      multimedia.thumbnail_width = video.thumbnail_width
      multimedia.thumbnail_height = video.thumbnail_height
      multimedia.visible_uri = video.visible_uri
      multimedia.duration = video.duration
      multimedia.source = SOURCE_GOOGLE
      multimedia.type = TYPE_VIDEO
      multimedia.save
    }
    local_search(query)
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
  def default_values
    self.source ||= SOURCE_APPLICATION
  end
  #
  # End private methods
end
