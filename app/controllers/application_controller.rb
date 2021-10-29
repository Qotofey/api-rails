class ApplicationController < ActionController::API
  include Authorization
  include Paginable

  rescue_from Pundit::NotAuthorizedError, with: :render_forbidden

  private

  def render_collection(collection, options = {})
    with_pagination = options.delete(:with_pagination) { true }
    serializer_class = with_pagination ? PaginatedCollectionSerializer : CollectionSerializer

    render json: serializer_class.new(collection, options).as_json
  end

  def render_ok
    render status: :ok
  end

  def render_created
    render status: :created
  end

  def render_accepted
    render status: :accepted
  end

  def render_forbidden
    render status: :forbidden
  end
end
