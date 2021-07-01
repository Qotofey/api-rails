module Confirmable
  extend ActiveSupport::Concern

  included do
    attr_writer :confirmed

    belongs_to :confirmed_by_user, class_name: 'User', optional: true

    before_save :check_confirmation

    scope :confirmed, -> { where.not(confirmed_at: nil) }
    scope :not_confirmed, -> { where(confirmed_at: nil) }
    scope :confirmed_after, ->(time) { where('confirmed_at > ?', time) }
    scope :confirmed_before, ->(time) { where('confirmed_at < ?', time) }
    scope :confirmed_from, ->(time) { where('confirmed_at >= ?', time) }
    scope :confirmed_to, ->(time) { where('confirmed_at <= ?', time) }
    scope :by_confirmed_by_user_id, ->(id) { where(confirmed_by_user_id: id) }
  end

  def confirmed?
    !!confirmed_at
  end

  def confirm
    self.confirmed_at = DateTime.now
    save(validate: false)
  end

  def unconfirm
    self.confirmed_at = nil
    save(validate: false)
  end

  private

  def check_confirmation
    return unless @confirmed.in? [false, true]

    self.confirmed_by_user_id = @confirmed ? current_user_id : nil
    self.confirmed_at = @confirmed ? DateTime.now : nil
  end
end
