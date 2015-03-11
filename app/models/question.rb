class Question < ActiveRecord::Base
  # Start external modules declaration
  #
  include PgSearch
  # Translated fields with globalize and for active admin
  active_admin_translates :content
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
  belongs_to :creator, polymorphic: true
  belongs_to :theme
  has_many :blocks, as: :blockable
  #
  # End relations declaration

  # Start validations declaration
  # Please try to maintain alphabetical order
  #
  validates :content, presence: true
  #
  # End validations declaration

  # Start callbacks declaration
  # Please try to maintain alphabetical order
  #
  after_update :retrain_machine
  #
  # End callbacks declaration

  # Start instance method declaration
  # Please try to maintain alphabetical order
  #
  def retrain_machine(force = false)
    if force || (theme_id_changed? && theme.present?)
      begin
        if theme.present?
          THEMES_BAYES_TRAINER.train theme.name, content
          update_column(:trained, true)
          THEMES_BAYES_TRAINER.save_state
        end
      rescue Exception => ex
        p ex.message
      end
    end
  end

  def train_machine(save_sate = false)
    if !trained? && theme.present?
      begin
        THEMES_BAYES_TRAINER.train theme.name, content
        update_attribute(:trained, true)
        THEMES_BAYES_TRAINER.save_state if save_sate
      rescue
        p 'Exception'
      end
    end
  end
  #
  # End instance method declaration

  # Start class method declaration
  # Please try to maintain alphabetical order
  #
  default_scope { includes(:translations) }
  pg_search_scope :search, against: :content, associated_against: { theme: :name }
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
  #
  # End private methods
end
