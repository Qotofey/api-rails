class UserFetcher < BaseFetcher
  def call
    @collection = collection_class.available(@current_user)
    fetch_only_fields
    apply_filtering
    apply_sorting

    pagination
    collection
  end

  private

  def include_tables
    %i[]
  end

  def collection_class
    ::User
  end
end
