class ApplicationPresenter
  attr_reader :collection, :params

  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 25
  MAX_PER_PAGE = 100

  def initialize(params)
    @collection = ApplicationRecord.none
    @params = params
  end

  private


  def apply_sorting
    collection_sort
  end

  def apply_selecting; end

  def apply_filtering; end

  def collection_sort
    values = params[:sort].to_s.split(',').map(&:strip)
    @collection = collection.ordered if values.empty?

    direction_values = %w[+ -]

    values.each do |value|
      direction = value[0]
      break unless direction.in? direction_values

      column = value[1..]
      @collection = collection.order(column => direction == '+' ? :asc : :desc)
    end
  end

  def include_tables
    raise NotImplementedError, "Method #{__method__} must be overridden"
  end

  def scoped_by_param(column_name)
    values = params[column_name].to_s.split(',').map(&:strip).map(&:downcase)
    return if values.blank?

    @collection = collection.send("by_#{column_name}", values.size.eql?(1) ? values.join : values)
  end

  def scoped_by_boolean_param(column_name); end

  def attribute_filter(attr); end

  def pagination
    @collection = collection.paginate(pagination_params)
  end

  def pagination_params
    { page: page, per_page: per_page }
  end

  def page
    params[:page].to_i.positive? ? params[:page] : DEFAULT_PAGE
  end

  def per_page
    size = params[:per_page].to_i
    return DEFAULT_PER_PAGE unless size.positive?
    return MAX_PER_PAGE if size > MAX_PER_PAGE

    size
  end
end
