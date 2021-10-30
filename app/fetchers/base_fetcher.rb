class BaseFetcher
  attr_reader :collection, :params, :only

  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 25
  MAX_PER_PAGE = 100

  def initialize(params)
    @collection = ApplicationRecord.none
    @params = params
  end

  private

  def collection_class
    raise NotImplementedError, "Method #{__method__} must be overridden"
  end

  def fetch_only_fields
    # @only ||= collection_class.column_names & params[:only].to_s.split(',').map(&:strip)
  end

  def apply_sorting
    base_sortable_collection
    custom_sortable_collection
  end

  def apply_filtering
    base_filterable_collection
    custom_filterable_collection
  end

  def custom_filterable_collection; end

  def custom_sortable_collection; end

  # `lt` - less then
  # `lte` - less than or equal to
  # `gt` - greater than
  # `gte` - greater than or equal to
  # `eq` - equal to
  # `ot` - other than
  #
  # `q` - sql LIKE
  def base_filterable_collection
    collection_class.column_names.each do |column_name|
      next if params[column_name].blank?

      value = params[column_name]['lte']
      @collection = collection.where("#{column_name} <= #{value}") if value.present?
      value = params[column_name]['lt']
      @collection = collection.where("#{column_name} < #{value}") if value.present?

      value = params[column_name]['gte']
      @collection = collection.where("#{column_name} >= #{value}") if value.present?
      value = params[column_name]['gt']
      @collection = collection.where("#{column_name} > #{value}") if value.present?

      values = params[column_name]['eq'].to_s.split(',').map(&:strip)
      @collection = collection.where(column_name => values) if values.present?
      values = params[column_name]['ot'].to_s.split(',').map(&:strip)
      @collection = collection.where.not(column_name => values) if values.present?
    end
  end

  def base_sortable_collection
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
