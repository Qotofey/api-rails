class CollectionSerializer
  attr_reader :collection, :each_serializer

  def initialize(collection, options)
    @collection = collection
    @each_serializer = options.delete(:each_serializer)
  end

  def as_json
    calculated_json
  end

  private

  def calculated_json
    collection.map { |record| each_serializer.new(record).as_json }
  end
end
