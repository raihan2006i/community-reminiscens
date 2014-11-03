module NameFilters
  extend ActiveSupport::Concern

  included do
    scope :case_sensitive_filter_by_name, ->(query) {
      where('name = ?', query)
    }
    scope :case_insensitive_filter_by_name, ->(query) {
      where('lower(name) = ?', query.downcase)
    }
  end
end