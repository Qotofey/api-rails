require_relative 'boot'

require 'rails'

require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module ApiRails
  class Application < Rails::Application
    I18n.config.available_locales = %i[en ru]
    config.i18n.default_locale = :ru

    config.load_defaults 6.1

    config.time_zone = 'Irkutsk'
    # config.eager_load_paths << Rails.root.join("extras")

    config.api_only = true

    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('app', 'validators')
    config.autoload_paths << Rails.root.join('app', 'services')
  end
end
