class PaginatedCollectionSerializer < CollectionSerializer
  protected

  def calculated_json
    {
      current_page: collection.current_page,
      per_page: collection.per_page,
      total_entries: collection.total_entries,
      entries: collection.map { |record| each_serializer.new(record).as_json }
    }
  end
end
