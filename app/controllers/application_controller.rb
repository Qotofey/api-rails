class ApplicationController < ActionController::API
  private

  def render_collection(collection, options = {})
    render json: PaginatedCollectionSerializer.new(collection, options).as_json
  end
end
