class Users::IndexPresenter < ApplicationPresenter
  def users
    @collection = ::User.available
    apply_filtering
    apply_sorting

    pagination
    collection
  end

  private

  def apply_filtering
    super
    filtering_collection
  end

  def filtering_collection
    scoped_by_param(:id)
    scoped_by_param(:promo)
    scoped_by_param(:email)
    scoped_by_param(:phone)
    scoped_by_param(:gender)
    scoped_by_param(:first_name)
    scoped_by_param(:middle_name)
    scoped_by_param(:last_name)
    scoped_by_param(:birth_date)
  end

  def include_tables
    %i[]
  end
end
