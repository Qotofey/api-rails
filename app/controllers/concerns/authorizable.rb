module Authorizable
  extend ActiveSupport::Concern

  included do
    include Pundit
  end
end
