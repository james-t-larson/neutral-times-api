ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "factory_bot_rails"
require "webmock/minitest"

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
  end
end
