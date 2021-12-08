module Authorizable
  extend ActiveSupport::Concern

  included do
    include Pundit
  end

  def active_user=(user)
    Thread.current[:current_user] = user
  end

  def active_user
    Thread.current[:current_user] || User.new
  end
end
