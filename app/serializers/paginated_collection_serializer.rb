class PaginatedCollectionSerializer
  attr_reader :collection, :each_serializer, :options

  def initialize(collection, options)
    @collection = collection
    @each_serializer = options.delete(:each_serializer)
    @options = options
  end

  def as_json
    calculated_json
  end

  private

  def calculated_json
    {
      current_page: collection.current_page,
      per_page: collection.per_page,
      total_entries: collection.total_entries,
      entries: collection.map { |record| each_serializer.new(record, options).as_json }
    }
  end
end
