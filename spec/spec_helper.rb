# Require all of the necessary gems
require "rspec"
require "capybara/rspec"
require "rack/jekyll"
require "rack/test"
require "pry"
require "selenium/webdriver"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  Capybara.register_driver :headless_chrome do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w(no-sandbox headless disable-gpu window-size=1400,1400) }
    )

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      desired_capabilities: capabilities,
      url: "http://selenium-chrome:4444/wd/hub"
    )
  end

  Capybara.javascript_driver = :headless_chrome
  Capybara.server = :webrick
  Capybara.app = Rack::Jekyll.new(force_build: false)
end
