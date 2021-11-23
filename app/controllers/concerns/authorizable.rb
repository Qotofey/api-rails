module Authorizable
  extend ActiveSupport::Concern

  included do
    include Pundit

    def current_user
      self.class.active_user
    end
  end

  def active_user=(user)
    Thread.current[:current_user] = user
  end

  def active_user
    Thread.current[:current_user] || User.new
  end
end
