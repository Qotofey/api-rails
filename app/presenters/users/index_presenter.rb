class Users::IndexPresenter < ApplicationPresenter
  def users
    @collection = User.available.includes(*include_tables).ordered

    pagination
    collection
  end

  def include_tables
    %i[]
  end
end
