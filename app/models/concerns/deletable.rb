module Deletable
  extend ActiveSupport::Concern

  included do
    attr_writer :deleted

    belongs_to :deleted_by_user, class_name: 'User', optional: true

    before_save :check_deletion

    scope :deleted, -> { where.not(deleted_at: nil) }
    scope :not_deleted, -> { where(deleted_at: nil) }
    scope :deleted_after, ->(time) { where('deleted_at > ?', time) }
    scope :deleted_before, ->(time) { where('deleted_at < ?', time) }
    scope :deleted_from, ->(time) { where('deleted_at >= ?', time) }
    scope :deleted_to, ->(time) { where('deleted_at <= ?', time) }
    scope :by_deleted_by_user_id, ->(id) { where(deleted_by_user_id: id) }
  end

  def deleted?
    !!deleted_at
  end

  def soft_destroy
    update_columns(
      deleted_at: DateTime.now,
      deleted_by_user_id: current_user_id
    )
  end

  def soft_restore
    assign_attributes(deleted_at: nil, deleted_by_user_id: nil)
    save(validate: false)
  end

  private

  def check_deletion
    return unless @deleted.in? [false, true]

    self.deleted_by_user_id = @deleted ? current_user_id : nil
    self.deleted_at = @deleted ? DateTime.now : nil
  end
end
