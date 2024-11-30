require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NeutralNewsApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2
    config.api_only = true
    config.time_zone = "Pacific Time (US & Canada)"
    config.active_record.yaml_column_permitted_classes = [ Time, Date, Symbol, ActiveSupport::TimeWithZone, ActiveSupport::TimeZone, ActiveSupport::HashWithIndifferentAccess ]

    config.generators do |g|
      g.test_framework :rspec
    end

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
    # config.autoload_paths += %W(#{config.root}/app/models)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
