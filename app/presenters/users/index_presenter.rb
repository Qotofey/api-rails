class Users::IndexPresenter < ApplicationPresenter
  def users
    @collection = User.available.ordered

    pagination
    collection
  end

  def include_tables
    %i[]
  end
end
