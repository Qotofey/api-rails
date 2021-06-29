class ApplicationController < ActionController::API
  private

  def render_collection(collection, options = {})
    with_pagination = options.delete(:with_pagination) { true }
    serializer_class = with_pagination ? PaginatedCollectionSerializer : CollectionSerializer

    render json: serializer_class.new(collection, options).as_json
  end
end
