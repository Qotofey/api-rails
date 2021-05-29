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

  def apply_filters; end

  def apply_order; end

  def include_tables; end

  def scoped_by_param(column_name)
    values = params[column_name].to_s.split(',').map(&:strip).map(&:downcase)
    return if values.blank?

    @collection = collection.send("by_#{column_name}", values.size.eql?(1) ? values.join : values)
  end

  def scoped_by_boolean_param(column_name); end

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
