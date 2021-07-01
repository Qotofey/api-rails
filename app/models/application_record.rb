class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :created_by_user, class_name: 'User', optional: true
  belongs_to :updated_by_user, class_name: 'User', optional: true

  scope :by_id, ->(ids) { where(id: ids) }
  scope :ordered, -> { order(created_at: :desc) }
  scope :reverse_ordered, -> { order(created_at: :asc) }
  scope :by_created_by_user_id, ->(user_id) { where(created_by_user_id: user_id) }
  scope :by_updated_by_user_id, ->(user_id) { where(updated_by_user_id: user_id) }
  scope :by_deleted_by_user_id, ->(user_id) { where(updated_by_user_id: user_id) }

  scope :created_after, ->(time) { where('created_at > ?', time) }
  scope :created_before, ->(time) { where('created_at < ?', time) }
  scope :created_from, ->(time) { where('created_at >= ?', time) }
  scope :created_to, ->(time) { where('created_at <= ?', time) }

  scope :updated_after, ->(time) { where('updated_at > ?', time) }
  scope :updated_before, ->(time) { where('updated_at < ?', time) }
  scope :updated_from, ->(time) { where('updated_at >= ?', time) }
  scope :updated_to, ->(time) { where('updated_at <= ?', time) }

  after_initialize :set_initiators
  before_save :check_update

  private

  def set_initiators
    return unless new_record?

    self.created_by_user_id ||= current_user_id if respond_to?(:created_by_user_id)
    self.updated_by_user_id ||= current_user_id if respond_to?(:updated_by_user_id)
  end

  def check_update
    self.updated_by_user_id ||= current_user_id if respond_to?(:updated_by_user_id)
  end

  def current_user_id
    nil
  end

  def current_user
    User.new
  end

  class << self
    def active_user=(user)
      Thread.current[:active_user] = user
    end

    def active_user
      Thread.current[:active_user] || User.new
    end
  end

  # class << self
  #   %i[integer string date datetime].each do |type_name|
  #     define_method "#{type_name}_column_names" do
  #       columns.find_all { |column| column.type == type_name }.map(&:name)
  #     end
  #   end
  #
  #   self.datetime_column_names.each do |column_name|
  #     define_method column_name do
  #       where.not("#{column_name}_at": nil)
  #     end
  #
  #     define_method "not_#{column_name}" do
  #       where("#{column_name}_at": nil)
  #     end
  #   end
  # end
end
