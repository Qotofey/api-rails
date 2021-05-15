class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :created_by_user, class_name: 'User', optional: true
  belongs_to :updated_by_user, class_name: 'User', optional: true
  belongs_to :deleted_by_user, class_name: 'User', optional: true

  scope :by_id, ->(ids) { where(id: ids) }
  scope :by_created_by_user_id, ->(user_id) { where(created_by_user_id: user_id) }
  scope :by_updated_by_user_id, ->(user_id) { where(updated_by_user_id: user_id) }
  scope :by_deleted_by_user_id, ->(user_id) { where(updated_by_user_id: user_id) }

  # scope :deleted, -> { where.not(deleted_at: nil) }
  # scope :not_deleted, -> { where(deleted_at: nil) }

  after_initialize :set_initiators

  def soft_destroy
    self.deleted_at = DateTime.now
    save(validate: false)
  end

  def soft_restore
    self.deleted_at = nil
    save(validate: false)
  end

  class << self
    %i[integer string date datetime].each do |type_name|
      define_method "#{type_name}_column_names" do
        columns.find_all { |column| column.type == type_name }.map(&:name)
      end
    end

    datetime_column_names.map { |name| name.sub(/_at$/, '') }.each do |column_name|
      define_method column_name do
        where.not("#{column_name}": nil)
      end

      define_method "not_#{column_name}" do
        where("#{column_name}": nil)
      end
    end
  end

  private

  def set_initiators; end
end
