require_relative "boot"

require "rails/all"

require 'csv'
require 'time'
require 'date'
require 'activerecord-import/base'
# load the appropriate database adapter (postgresql, mysql2, sqlite3, etc)
require 'activerecord-import/active_record/adapters/postgresql_adapter'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Weblog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
