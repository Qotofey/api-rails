class Users::IndexPresenter < ApplicationPresenter
  def users
    @collection = collection_class.available
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
