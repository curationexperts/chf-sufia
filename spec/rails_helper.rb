# This file is copied to spec/ when you run 'rails generate rspec:install'
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'spec_helper'
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!
require 'webmock/rspec'
require 'capybara/rspec'
require 'capybara/poltergeist'
#This is off for now since capybara is 100% problems
#require 'capybara-screenshot/rspec'
require 'database_cleaner'
require 'active_fedora/cleaner'
require 'devise'
require 'support/features'
require 'support/rake'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false, phantomjs: Phantomjs.path)
end

Capybara.default_driver = :rack_test      # This is a faster driver
Capybara.javascript_driver = :poltergeist # This is slower
#Capybara.default_wait_time = 20

RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :feature
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.after(:each, type: :feature) { Warden.test_reset! }

  config.before :suite do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before :each do |example|
    unless example.metadata[:type] == :view || example.metadata[:no_clean]
      ActiveFedora::Cleaner.clean!
    end
  end

  config.before :each do |example|
    if example.metadata[:type] == :feature && Capybara.current_driver != :rack_test
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Allow local http connections
  WebMock.disable_net_connect!(:allow_localhost => true)
end

def webmock_fixture fixture
    File.new File.expand_path(File.join("../fixtures", fixture),  __FILE__)
end
