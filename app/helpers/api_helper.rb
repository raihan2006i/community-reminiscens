module ApiHelper
  def pagination_information(collection)
    {
        previous: collection.try(:previous_page),
        next: collection.try(:next_page),
        current: collection.try(:current_page),
        per_page: collection.try(:per_page),
        count: collection.try(:total_entries),
        pages: collection.try(:total_pages)
    }
  end
end